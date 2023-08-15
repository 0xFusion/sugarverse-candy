// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

/**
 * @title AirdropCandyToken
 * @dev An ERC20 token contract that supports burning, capping, ownership management, and pausing.
 */
contract AirdropCandyToken is ERC20Burnable, ERC20Capped, Ownable, Pausable {

    /**
     * @dev Initializes the AirdropCandyToken contract.
     * @param _owner The initial owner of the contract.
     */
    constructor(address _owner, uint256 _initialMint, uint256 _maxSupply) ERC20Capped(_maxSupply) ERC20("Airdrop CNDY", "AIRDROPCNDY") {
        _transferOwnership(_owner);
        _mint(owner(), _initialMint);
    }

    /**
     * @dev Mints new tokens and assigns them to the specified account.
     * @param to The recipient address for the minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) public virtual onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Burns a specific amount of tokens owned by the caller.
     * @param amount The amount of tokens to burn.
     * @notice This function burns the specified amount of tokens from the caller's balance.
     */
    function burn(uint256 amount) public virtual override whenNotPaused {
        super.burn(amount);
    }

    /**
     * @dev Burns a specific amount of tokens from the specified account.
     * @param account The address whose tokens will be burned.
     * @param amount The amount of tokens to burn.
     * @notice This function burns the specified amount of tokens from the provided account's balance.
     */
    function burnFrom(address account, uint256 amount) public virtual override whenNotPaused {
        super.burnFrom(account, amount);
    }

    /**
     * @dev Overrides the ERC20.transfer function to add a pause check.
     * @param to The recipient address to transfer tokens to.
     * @param amount The amount of tokens to transfer.
     * @return A boolean indicating whether the transfer was successful.
     */
    function transfer(address to, uint256 amount) public virtual override(ERC20) whenNotPaused returns (bool) {
        return super.transfer(to, amount);
    }

    /**
     * @dev Overrides the ERC20.transferFrom function to add a pause check.
     * @param from The sender address to transfer tokens from.
     * @param to The recipient address to transfer tokens to.
     * @param amount The amount of tokens to transfer.
     * @return A boolean indicating whether the transfer was successful.
     */
    function transferFrom(address from, address to, uint256 amount)
        public
        virtual
        override(ERC20)
        whenNotPaused
        returns (bool)
    {
        return super.transferFrom(from, to, amount);
    }

    /**
     * @dev Pauses the contract, preventing all token transfers.
     * Can only be called by the owner.
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev Unpauses the contract, allowing token transfers to resume.
     * Can only be called by the owner.
     */
    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * @dev Internal function to mint tokens.
     * Overrides the internal minting functions of ERC20 and ERC20Capped.
     * @param account The account to receive the minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function _mint(address account, uint256 amount) internal virtual override(ERC20, ERC20Capped) {
        super._mint(account, amount);
    }
}
