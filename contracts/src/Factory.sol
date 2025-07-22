// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.20;

import "./interfaces/IFactory.sol";
import "./ERC20Token.sol";
import "./ERC721Token.sol";
import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

// @TO-DO: Pausable
contract Factory is IFactory, Ownable {
    address public immutable erc20Implementation;
    address public immutable erc721Implementation;

    address[] public allERC20;
    address[] public allERC721;

    mapping(address => bool) public hasCreatedERC20;
    mapping(address => bool) public hasCreatedERC721;

    mapping(address => address) public userToERC20;
    mapping(address => address) public userToERC721;

    constructor() Ownable(msg.sender) {
        // Deploy he ERC20 implementation only once
        erc20Implementation = address(new ERC20Token());

        // Deploy the ERC721 implementation only once
        erc721Implementation = address(new ERC721Token());
    }

    // --- Factory Functions ---

    function createERC20(string memory name, string memory symbol, uint256 initialSupply) external returns (address) {
        require(!hasCreatedERC20[msg.sender], "Factory: User has already created an ERC20 contract");

        // 1. Clonar
        address cloneAddress = Clones.clone(erc20Implementation);

        // 2. Inicializar el clon
        ERC20Token(cloneAddress).initialize(name, symbol, initialSupply, msg.sender);

        // Update state
        hasCreatedERC20[msg.sender] = true;
        userToERC20[msg.sender] = cloneAddress;
        allERC20.push(cloneAddress);

        emit ERC20TokenCreated(msg.sender, cloneAddress);

        return cloneAddress;
    }

    /**
     * @dev Creates a new ERC721 collection by cloning a base implementation.
     */
    function createERC721(string memory name, string memory symbol) external override returns (address) {
        require(!hasCreatedERC721[msg.sender], "Factory: Caller has already created an ERC721 collection");

        // 1. Clone the implementation contract
        address cloneAddress = Clones.clone(erc721Implementation);

        // 2. Initialize the newly created clone
        ERC721Token(cloneAddress).initialize(name, symbol, msg.sender);

        // Update state (same as before)
        hasCreatedERC721[msg.sender] = true;
        userToERC721[msg.sender] = cloneAddress;
        allERC721.push(cloneAddress);

        emit ERC721CollectionCreated(msg.sender, cloneAddress);

        return cloneAddress;
    }

    // --- Getter Functions ---

    /**
     * @dev Returns the address of the ERC20 token created by a specific user.
     */
    function getERC20ByUser(address user) external view returns (address) {
        return userToERC20[user];
    }

    /**
     * @dev Returns the address of the ERC721 collection created by a specific user.
     */
    function getERC721ByUser(address user) external view returns (address) {
        return userToERC721[user];
    }

    /**
     * @dev Returns an array with all created ERC20 token addresses.
     */
    function getAllERC20() external view returns (address[] memory) {
        return allERC20;
    }

    /**
     * @dev Returns an array with all created ERC721 collection addresses.
     */
    function getAllERC721() external view returns (address[] memory) {
        return allERC721;
    }
}
