const hre = require("hardhat");

// Main function
async function main() {
	const [owner] = await hre.ethers.getSigners();

	const ChainlinkNFTContractFactory = await hre.ethers.getContractFactory(
		"ChainlinkNFT"
	);

	const CONTRACT_ADDRESS = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

	const ChainlinkNFT = await ChainlinkNFTContractFactory.attach(
		CONTRACT_ADDRESS
	);

	// Minting First NFT
	await ChainlinkNFT.connect(owner).mint();
	await ChainlinkNFT.connect(owner).mint();
	await ChainlinkNFT.connect(owner).mint();

	// Initial NFT
	const initialLink = await ChainlinkNFT.connect(owner).tokenIdToLink(1);
	console.log("Initial link is ", initialLink);

	console.log("\nInitial NFT is:");
	const initialNFT = await ChainlinkNFT.getTokenURI(1);
	console.log(initialNFT);

	// Updated NFT
	await ChainlinkNFT.connect(owner).changeLink(1, "githubotoro");

	const updatedLink = await ChainlinkNFT.connect(owner).tokenIdToLink(1);
	console.log("\nUpdated link is ", updatedLink);

	console.log("\nUpdated NFT is:");

	const updatedNFT = await ChainlinkNFT.getTokenURI(1);
	console.log(updatedNFT);
}

main().then(() =>
	process.exit(0).catch((error) => {
		console.log(error);
		process.exit(1);
	})
);
