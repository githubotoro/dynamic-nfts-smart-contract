//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Openzeppelin Imports
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

// Chainlink Imports
import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract ChainlinkNFT is ChainlinkClient, ConfirmedOwner, ERC721URIStorage {
    using Chainlink for Chainlink.Request;
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => string) public tokenIdToLink;
    mapping(uint256 => string) public tokenIdToLinkName;
    mapping(bytes32 => uint256) public requestIdToTokenId;

    bytes32 private jobId;
    uint256 private fee;

    /**
     * Polygon Mumbai Testnet Details:
     * Link Token: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB
     * Oracle: 0x40193c8518BB267228Fc409a613bDbD8eC5a97b3
     * jobId (string): 7d80a6386ef543a3abb52817f6707e3b
     */
    constructor() ConfirmedOwner(msg.sender) ERC721("DynamicNFT", "DNFT") {
        setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
        setChainlinkOracle(0x40193c8518BB267228Fc409a613bDbD8eC5a97b3);
        jobId = "7d80a6386ef543a3abb52817f6707e3b";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0.1 * 10**18 (0.1 LINK Token)
    }

    function generateNFT(uint256 tokenId) public view returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">',
            '<a href="',
            getLink(tokenId),
            '">',
            '<text x="50" y="50" text-anchor="middle">',
            "&lt;",
            getLinkName(tokenId),
            "&gt;",
            "</text>",
            "</a>",
            "</svg>"
        );

        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getLink(uint256 tokenId) public view returns (string memory) {
        string memory link = tokenIdToLink[tokenId];
        return link;
    }

    function getLinkName(uint256 tokenId) public view returns (string memory) {
        string memory linkName = tokenIdToLinkName[tokenId];
        return linkName;
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Dynamic NFT #',
            tokenId.toString(),
            '",',
            '"description": "NFT that can be changed dynamically.",',
            '"image": "',
            generateNFT(tokenId),
            '"',
            "}"
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _safeMint(msg.sender, newItemId);

        tokenIdToLink[newItemId] = "https://github.com/patelsaumya";
        tokenIdToLinkName[newItemId] = "patelsaumya";

        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function update(uint256 tokenId, string memory username) public {
        require(_exists(tokenId));
        require(ownerOf(tokenId) == msg.sender, "Only owner can update NFT.");

        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfillChangeLink.selector
        );

        string memory requestLink = string(
            abi.encodePacked("https://api.github.com/users/", username)
        );

        req.add("get", requestLink);
        req.add("path", "login");
        req.add("path", "html_url");

        bytes32 _requestId = sendChainlinkRequest(req, fee);

        requestIdToTokenId[_requestId] = tokenId;
    }

    event ChangeLinkRequestFulfilled(bytes32 indexed requestId);

    function fulfillChangeLink(
        bytes32 requestId,
        string memory newLink,
        string memory newLinkName
    ) public recordChainlinkFulfillment(requestId) {
        emit ChangeLinkRequestFulfilled(requestId);

        uint256 tokenId = requestIdToTokenId[requestId];

        tokenIdToLink[tokenId] = newLink;
        tokenIdToLinkName[tokenId] = newLinkName;

        _setTokenURI(tokenId, getTokenURI(tokenId));
    }

    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(
            link.transfer(msg.sender, link.balanceOf(address(this))),
            "Only owner can withdraw funds."
        );
    }
}
