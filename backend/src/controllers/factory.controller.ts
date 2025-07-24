import { Request, Response } from "express";
import { factoryContract } from "../services/ethers.service";
import { ethers } from "ethers";

// Interface for the getUserCreations route parameters
interface UserCreationsParams {
  userAddress: string;
}

/**
 * @desc    Get the total counts of created tokens
 * @route   GET /factory/counts
 */
export const getCreationCounts = async (req: Request, res: Response) => {
  try {
    const allErc20s = await factoryContract.getAllERC20();
    const allErc721s = await factoryContract.getAllERC721();
    const erc20Count = allErc20s.length;
    const erc721Count = allErc721s.length;

    res.status(200).json({
      erc20Count: erc20Count,
      erc721Count: erc721Count,
      total: erc20Count + erc721Count,
    });
  } catch (error) {
    res.status(500).json({
      message: "Error fetching token counts",
      error: (error as Error).message,
    });
  }
};

/**
 * @desc    Checks if a user has created an ERC20 or ERC721 token.
 * @route   GET /factory/creations/:userAddress
 */
export const getUserCreations = async (
  req: Request<UserCreationsParams>,
  res: Response
) => {
  try {
    const { userAddress } = req.params;

    if (!ethers.isAddress(userAddress)) {
      return res.status(400).json({ message: "Invalid user address supplied" });
    }

    // The zero address is used to signify that no contract has been created.
    const zeroAddress = "0x0000000000000000000000000000000000000000";

    const [erc20TokenAddress, erc721TokenAddress] = await Promise.all([
      factoryContract.getERC20ByUser(userAddress),
      factoryContract.getERC721ByUser(userAddress),
    ]);

    const hasCreatedERC20 = erc20TokenAddress !== zeroAddress;
    const hasCreatedERC721 = erc721TokenAddress !== zeroAddress;

    if (hasCreatedERC20 || hasCreatedERC721) {
      // If the user created at least one, return user's address
      res.status(200).json({
        status: true,
        userAddress: userAddress,
      });
    } else {
      // If the user has created none, return false as requested.
      res.status(200).json({
        status: false,
        userAddress: zeroAddress,
      });
    }
  } catch (error) {
    res.status(500).json({
      message: "Error fetching user creations",
      error: (error as Error).message,
    });
  }
};
