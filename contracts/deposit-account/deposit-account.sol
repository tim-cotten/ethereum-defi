pragma solidity >=0.4.22 <0.6.0;

/**
 * @title DepositAccount v1.0.0 - deposit and withdraw ether by owner
 * @author Tim Cotten <tim@cotten.io>
 */
contract DepositAccount {
    address private owner;
    
    /// @dev Only the owner can withdraw from this contract
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    /// @dev The requested withdrawal amount must be available in the contract balance
    modifier withMinBalance(uint256 amount) {
        require(address(this).balance >= amount);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }
    
    /// @dev Allow deposits from anyone
    function() external payable {}
    
    /// @dev Full withdrawal
    function withdraw() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);
    }
    
    /// @dev Partial withdrawal
    /// @param amount Amount requested for withdrawal
    function withdraw(uint256 amount) public payable onlyOwner withMinBalance(amount) {
        msg.sender.transfer(amount);
    }
}
