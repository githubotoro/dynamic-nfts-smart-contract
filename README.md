# Dynamic NFTs - Empowering realtime on-chain updates 🔗

🔍 This project helps in creating NFTs that are stored as smart contracts while leveraging Chainlink's features for providing off-chain updation of NFTs.

📌 It is currently under active development, do check out the repo regularly for updates.

<!-- GETTING STARTED -->

<a name="getting-started"></a>

## Getting Started 🚀

All you need to get started with this project is basic knowledge about working of **NFTs!** 💯

<a name="installation"></a>

### Installation 💻

1.  **Clone** this repo.

    ```sh
    git clone https://github.com/githubotoro/dynamic-nfts-smart-contract.git
    ```

2.  Get your own **Alchemy API URL** on **"Polygon Mumbai Testnet"** from **[Alchemy](https://www.alchemy.com/).** Get your **Private Key** under Account Details from Metamask. Make a **.env** file in the root directory and enter the following lines.

    ```sh
    ALCHEMY_POLYGON_URL = "YOUR_ALCHEMY_POLYGON_API_URL"
    PRIVATE_KEY = "YOUR_PRIVATE_KEY"
    ```

    > **NOTE: Never push .env file to GitHub or you will lose all your funds as Mainnet and Testnet share the same Private Key.**

3.  **(Optional)** You can also add **PolygonScan API Key** from **[PolygonScan Mumbai](https://mumbai.polygonscan.com/)** and add it your .env file. This can be used to **verify** smart contract on PolygonScan Mumbai network.

    ```sh
    POLYGONSCAN_API_KEY = "YOUR_POLYGONSCAN_KEY"
    ```

    You can **verify smart contract** after deployemnt using below command:

    ```js
    npx hardhat verify "YOUR_SMART_CONTRACT_ADDRESS" --network mumbai
    ```

4.  **Install** NPM packages.

    ```sh
    npm install
    ```

5.  Deploying and testing **(Locally)**. You can find test and deployment scripts under **Scripts** folder.

    ```sh
    npx hardhat run scripts/<"SCRIPT NAME">
    ```

6.  Deploying and testing **(Polygon Testnet)**. If you don't have **MATIC**, get some for free from **[Polygon Faucet](https://mumbaifaucet.com/)** for deployment and making transactions. You would also require **LINK** token to fund the Chainlink smart contract. You can get some for free from **[Chainlink Faucet](https://faucets.chain.link/)** for adding interactivity to smart contracts.

    ```sh
    npx hardhat run scripts/<"SCRIPT NAME"> --network mumbai
    ```

7.  **Time to turn those static NFTs to dynamic ones... 👀**

<!-- GETTING STARTED -->

<!-- CONTRIBUTING -->

<a name="contributing"></a>

## Contributing 🤝

This is a community project and any contributions you make are greatly appreciated. If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "dnft". 🏷

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/DnftFeature`)
3. Commit your Changes (`git commit -m 'Add some DnftFeature'`)
4. Push to the Branch (`git push origin feature/DnftFeature`)
5. Open a Pull Request

<!-- CONTRIBUTING -->

<!-- LICENSE -->

<a name="license"></a>

## License 📃

Distributed under the **MIT License**. See `LICENSE` for more information.

<!-- LICENSE -->
