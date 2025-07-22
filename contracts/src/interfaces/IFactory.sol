// SPDX-License-Identifier: MIT
pragma solidity = 0.8.20;

interface IFactory {
    /**
     * @dev Se emite cuando un nuevo contrato de token ERC20 es creado.
     * @param creator La dirección del usuario que crea el token.
     * @param tokenAddress La dirección del nuevo contrato ERC20 desplegado.
     */
    event ERC20TokenCreated(address indexed creator, address indexed tokenAddress);

    /**
     * @dev Se emite cuando una nueva colección de tokens ERC721 es creada.
     * @param creator La dirección del usuario que crea la colección.
     * @param collectionAddress La dirección del nuevo contrato ERC721 desplegado.
     */
    event ERC721TokenCreated(address indexed creator, address indexed collectionAddress);

    /**
     * @dev Crea y despliega un nuevo contrato de token ERC20.
     * El despliegue fallará si el msg.sender ya ha creado un ERC20 previamente.
     * @param name El nombre del token (ej. "Mi Token").
     * @param symbol El símbolo del token (ej. "MTK").
     * @param initialSupply La cantidad inicial de tokens a acuñar para el creador.
     * @return La dirección del contrato ERC20 recién creado.
     */
    function createERC20(string memory name, string memory symbol, uint256 initialSupply) external returns (address);

    /**
     * @dev Crea y despliega un nuevo contrato de colección ERC721.
     * El despliegue fallará si el msg.sender ya ha creado un ERC721 previamente.
     * @param name El nombre de la colección (ej. "Mi Colección NFT").
     * @param symbol El símbolo de la colección (ej. "MCN").
     * @return La dirección del contrato ERC721 recién creado.
     */
    function createERC721(string memory name, string memory symbol) external returns (address);

    /**
     * @dev Devuelve la dirección del token ERC20 creado por un usuario específico.
     * @param user La dirección del usuario a consultar.
     * @return La dirección del contrato ERC20, o la dirección cero si no ha creado ninguno.
     */
    function getERC20ByUser(address user) external view returns (address);

    /**
     * @dev Devuelve la dirección de la colección ERC721 creada por un usuario específico.
     * @param user La dirección del usuario a consultar.
     * @return La dirección del contrato ERC721, o la dirección cero si no ha creado ninguna.
     */
    function getERC721ByUser(address user) external view returns (address);

    function getAllERC20() external view returns (address[] memory);

    function getAllERC721() external view returns (address[] memory);
}
