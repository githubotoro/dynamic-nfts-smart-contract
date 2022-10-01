const hre = require("hardhat");

const main = async () => {
	try {
		const DeploymentContractFactory = await hre.ethers.getContractFactory(
			"CustomLinkNFT"
		);
		const DeploymentContract = await DeploymentContractFactory.deploy();
		await DeploymentContract.deployed();

		console.log("Contract deployed to:", DeploymentContract.address);
		process.exit(0);
	} catch (err) {
		console.log(err);
		process.exit(1);
	}
};

main();
