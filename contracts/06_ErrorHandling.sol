// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ErrorHandling {
    uint256 public balance;
    address public owner;
    
    error InsufficientBalance(uint256 requested, uint256 available);
    error Unauthorized(address caller);
    error InvalidAmount();
    
    constructor() {
        owner = msg.sender;
        balance = 1000;
    }
    
    function withdrawWithRequire(uint256 amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(amount > 0, "Amount must be greater than 0");
        require(balance >= amount, "Insufficient balance");
        
        balance -= amount;
    }
    
    function withdrawWithRevert(uint256 amount) public {
        if (msg.sender != owner) {
            revert("Only owner can withdraw");
        }
        if (amount == 0) {
            revert("Amount must be greater than 0");
        }
        if (balance < amount) {
            revert("Insufficient balance");
        }
        
        balance -= amount;
    }
    
    function withdrawWithCustomError(uint256 amount) public {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }
        if (amount == 0) {
            revert InvalidAmount();
        }
        if (balance < amount) {
            revert InsufficientBalance(amount, balance);
        }
        
        balance -= amount;
    }
    
    function withdrawWithAssert(uint256 amount) public {
        assert(msg.sender == owner);
        assert(amount > 0);
        assert(balance >= amount);
        
        balance -= amount;
    }
    
    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        require(b != 0, "Division by zero");
        return a / b;
    }
    
    function deposit(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        balance += amount;
    }
}