require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const QUICKNODE_API_KEY_URL = process.env.QUICKNODE_API_KEY_URL;
const SEPOLIA_PRIVATE_KEY = process.env.SEPOLIA_PRIVATE_KEY;


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    sepolia: {
      url: QUICKNODE_API_KEY_URL,
      accounts: [SEPOLIA_PRIVATE_KEY]
    }
  }

};
