// src/controllers/token.controller.ts
import { Request, Response } from "express";
import { getErc20Contract } from "../services/ethers.service";
import { ethers } from "ethers";

interface TokenBalanceParams {
  tokenAddress: string;
  userAddress: string;
}

/**
 * @desc    Get a user's balance for a specific ERC20 token
 * @route   GET /api/token/balance/:tokenAddress/:userAddress
 */
export const getTokenBalance = async (
  req: Request<TokenBalanceParams>,
  res: Response
) => {
  try {
    const { tokenAddress, userAddress } = req.params;
    if (!ethers.isAddress(tokenAddress) || !ethers.isAddress(userAddress)) {
      return res
        .status(400)
        .json({ message: "Invalid token or user address supplied" });
    }

    const erc20Contract = getErc20Contract(tokenAddress);

    // Fetch balance and symbol in parallel for better performance
    const [balance, symbol] = await Promise.all([
      erc20Contract.balanceOf(userAddress),
      erc20Contract.symbol(),
    ]);

    res.status(200).json({
      userAddress,
      tokenAddress,
      symbol,
      balance: ethers.formatEther(balance), // Formats from Wei to a readable string
    });
  } catch (error) {
    res.status(500).json({
      message: "Error fetching token balance",
      error: (error as Error).message,
    });
  }
};
