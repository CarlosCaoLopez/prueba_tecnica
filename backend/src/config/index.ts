// src/config/index.ts
import dotenv from "dotenv";

dotenv.config();

export const config = {
  rpcUrl: process.env.RPC_URL!,
  privateKey: process.env.PRIVATE_KEY!,
  factoryAddress: process.env.FACTORY_CONTRACT_ADDRESS!,
};

// Basic validation to ensure environment variables are set
if (!config.rpcUrl || !config.privateKey || !config.factoryAddress) {
  throw new Error(
    "Missing required environment variables. Check your .env file."
  );
}
