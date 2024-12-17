// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FunctionModifiers {
    address public owner;
    uint256 public count;
    bool public paused;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    
    modifier notPaused() {
        require(!paused, "Contract is paused");
        _;
    }
    
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Invalid address");
        _;
    }
    
    function increment() public notPaused {
        count++;
    }
    
    function decrement() public notPaused {
        require(count > 0, "Count cannot be negative");
        count--;
    }
    
    function setPaused(bool _paused) public onlyOwner {
        paused = _paused;
    }
    
    function transferOwnership(address newOwner) public onlyOwner validAddress(newOwner) {
        owner = newOwner;
    }
    
    function reset() public onlyOwner notPaused {
        count = 0;
    }
}