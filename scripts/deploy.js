const main = async () => {
	try {
		const DynamicNFTContractFactory = await hre.ethers.getContractFactory(
			"DynamicNFT"
		);
		const DynamicNFTContract = await DynamicNFTContractFactory.deploy();
		await DynamicNFTContract.deployed();

		console.log("Contract deployed to:", DynamicNFTContract.address);
		process.exit(0);
	} catch (err) {
		console.log(err);
		process.exit(1);
	}
};

main();
