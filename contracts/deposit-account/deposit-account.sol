pragma solidity >=0.4.22 <0.6.0;

/**
 * @title DepositAccount v1.0.0 - deposit and withdraw ether by owner
 * @author Tim Cotten <tim@cotten.io>
 */
contract DepositAccount {
    address private owner;
    
    /// @notice Only the owner can withdraw from this contract
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    /// @notice The requested withdrawal amount must be available in the contract balance
    modifier withMinBalance(uint256 amount) {
        require(address(this).balance >= amount);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }
    
    /// @notice Allow deposits from anyone
    function() external payable {}
    
    /// @notice Full withdrawal
    function withdraw() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);
    }
    
    /// @notice Partial withdrawal
    /// @param amount Amount requested for withdrawal
    function withdraw(uint256 amount) public payable onlyOwner withMinBalance(amount) {
        msg.sender.transfer(amount);
    }
}
