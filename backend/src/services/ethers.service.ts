// blockchain conexion logic
// src/services/ethers.service.ts
import { ethers } from "ethers";
import { config } from "../config";
import FactoryABI from "../abis/Factory.json";
import ERC20ABI from "../abis/ERC20Token.json";

// 1. Provider to connect to the blockchain (Anvil)
export const provider = new ethers.JsonRpcProvider(config.rpcUrl);

// 2. Signer to send transactions (using your private key)
export const signer = new ethers.Wallet(config.privateKey, provider);

// 3. Factory Contract instance to interact with it
export const factoryContract = new ethers.Contract(
  config.factoryAddress,
  FactoryABI.abi,
  signer
);

// 4. Helper function to get an instance of any ERC20 token
export const getErc20Contract = (tokenAddress: string) => {
  return new ethers.Contract(tokenAddress, ERC20ABI.abi, provider);
};

console.log(`Connected to Factory contract at: ${config.factoryAddress}`);
