// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract DynamicNFT is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => string) public tokenIdToLink;
    mapping(uint256 => string) public tokenIdToLinkName;

    constructor() ERC721("DynamicNFT", "DNFT") {}

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
        tokenIdToLinkName[newItemId] = "Saumya";

        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function update(
        uint256 tokenId,
        string memory newLink,
        string memory newLinkName
    ) public {
        require(_exists(tokenId));
        require(ownerOf(tokenId) == msg.sender, "Only owner can update NFT.");

        tokenIdToLink[tokenId] = newLink;
        tokenIdToLinkName[tokenId] = newLinkName;

        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}
