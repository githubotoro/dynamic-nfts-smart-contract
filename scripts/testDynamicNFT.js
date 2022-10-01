const hre = require("hardhat");

// Main function
async function main() {
	const [owner] = await hre.ethers.getSigners();

	// Deploying smart contract
	const DynamicNFTContractFactory = await hre.ethers.getContractFactory(
		"DynamicNFT"
	);
	const DynamicNFT = await DynamicNFTContractFactory.deploy();
	await DynamicNFT.deployed();

	console.log(`\nDynamicNFT contract has been deplyed.`);
	console.log(`\nDeployed to: ${DynamicNFT.address}`);
	console.log(`Deployed by: ${owner.address}\n`);

	// Minting First NFT
	await DynamicNFT.connect(owner).mint();

	// Initial NFT
	const initialLink = await DynamicNFT.connect(owner).tokenIdToLink(1);
	console.log("Initial link is ", initialLink);

	console.log("\nInitial NFT is:");
	const initialNFT = await DynamicNFT.getTokenURI(1);
	console.log(initialNFT);

	// Updated NFT
	await DynamicNFT.connect(owner).update(
		1,
		"https://github.com/githubotoro",
		"githubotoro"
	);

	const updatedLink = await DynamicNFT.connect(owner).tokenIdToLink(1);
	console.log("\nUpdated link is ", updatedLink);

	console.log("\nUpdated NFT is:");

	const updatedNFT = await DynamicNFT.getTokenURI(1);
	console.log(updatedNFT);
}

main().then(() =>
	process.exit(0).catch((error) => {
		console.log(error);
		process.exit(1);
	})
);
