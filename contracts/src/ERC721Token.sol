// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ERC721Token
 * @dev A standard ERC721 collection template.
 * The contract is Ownable, with the creator set as the initial owner.
 * The owner can mint new tokens.
 */
contract ERC721Token is ERC721, Ownable {
    uint256 private _nextTokenId;

    constructor(string memory name, string memory symbol, address initialOwner)
        ERC721(name, symbol)
        Ownable(initialOwner)
    {}

    /**
     * @dev Mints a new token to a specified address. Can only be called by the owner.
     * @param to The address that will receive the minted token.
     */
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }
}
