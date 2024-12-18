// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract PayableContract {
    address public owner;
    mapping(address => uint256) public deposits;
    
    event Received(address sender, uint256 amount);
    event Withdrawn(address recipient, uint256 amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    
    receive() external payable {
        deposits[msg.sender] += msg.value;
        emit Received(msg.sender, msg.value);
    }
    
    fallback() external payable {
        deposits[msg.sender] += msg.value;
        emit Received(msg.sender, msg.value);
    }
    
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        deposits[msg.sender] += msg.value;
        emit Received(msg.sender, msg.value);
    }
    
    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient deposit");
        deposits[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }
    
    function withdrawAll() external {
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "No deposits to withdraw");
        deposits[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }
    
    function emergencyWithdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
    
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    function getUserDeposit(address user) external view returns (uint256) {
        return deposits[user];
    }
}