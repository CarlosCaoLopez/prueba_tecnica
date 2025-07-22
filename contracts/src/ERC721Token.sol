// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Import the correct "upgradeable" versions
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @title ERC721Token
 * @dev An initializable ERC721 collection template for use with clones.
 */
contract ERC721Token is Initializable, ERC721Upgradeable, OwnableUpgradeable {
    uint256 private _nextTokenId;

    /**
     * @dev The constructor is left empty for clones.
     */
    constructor() {
        _disableInitializers();
    }

    /**
     * @dev Initializes the ERC721 collection. Replaces the constructor logic.
     */
    function initialize(string memory name, string memory symbol, address initialOwner) public initializer {
        // Call the initializers of the parent contracts
        __ERC721_init(name, symbol);
        __Ownable_init(initialOwner);
    }

    /**
     * @dev Mints a new token to a specified address. Can only be called by the owner.
     */
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }
}
