// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @title ERC20Token
 * @dev A standard ERC20 token contract template.
 * The entire initial supply is minted to the creator upon construction.
 */
contract ERC20Token is Initializable, ERC20Upgradeable {
    constructor() {
        _disableInitializers();
    }

    function initialize(string memory name, string memory symbol, uint256 initialSupply, address creator)
        public
        initializer
    {
        __ERC20_init(name, symbol);
        _mint(creator, initialSupply);
    }
}
