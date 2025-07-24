// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import {Factory} from "../src/Factory.sol";
import {ERC20Token} from "../src/ERC20Token.sol";
import {ERC721Token} from "../src/ERC721Token.sol";

contract Deploy is Script {
    function run() external returns (Factory) {
        // Start broadcasting transactions
        vm.startBroadcast();

        // 1. Deploy the implementation contracts first
        ERC20Token erc20Impl = new ERC20Token();
        console.log("ERC20 Implementation deployed at:", address(erc20Impl));

        ERC721Token erc721Impl = new ERC721Token();
        console.log("ERC721 Implementation deployed at:", address(erc721Impl));

        // 2. Deploy the Factory
        Factory factory = new Factory();
        console.log("Factory deployed at:", address(factory));

        // Stop broadcasting
        vm.stopBroadcast();

        return factory;
    }
}
