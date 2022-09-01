const hre = require("hardhat");

// Main function
async function main() {
	const [owner] = await hre.ethers.getSigners();

	// Deploying smart contract
	const ChainlinkNFTContractFactory = await hre.ethers.getContractFactory(
		"ChainlinkNFT"
	);
	const ChainlinkNFT = await ChainlinkNFTContractFactory.deploy();
	await ChainlinkNFT.deployed();

	console.log(`\nChainlinkNFT contract has been deplyed.`);
	console.log(`\nDeployed to: ${ChainlinkNFT.address}`);
	console.log(`Deployed by: ${owner.address}\n`);
}

main().then(() =>
	process.exit(0).catch((error) => {
		console.log(error);
		process.exit(1);
	})
);

// npx hardhat fund-link --contract 0x5FbDB2315678afecb367f032d93F642f64180aa3 --linkaddress 0x326C977E6efc84E512bB9C30f76E30c160eD06FB --fundamount 100000000000000000000
