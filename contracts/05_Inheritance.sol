// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Animal {
    string public name;
    
    constructor(string memory _name) {
        name = _name;
    }
    
    function speak() public virtual pure returns (string memory) {
        return "Some generic animal sound";
    }
    
    function sleep() public pure returns (string memory) {
        return "ZZZ...";
    }
}

contract Dog is Animal {
    constructor(string memory _name) Animal(_name) {}
    
    function speak() public pure override returns (string memory) {
        return "Woof!";
    }
    
    function wagTail() public pure returns (string memory) {
        return "Wagging tail happily!";
    }
}

contract Cat is Animal {
    constructor(string memory _name) Animal(_name) {}
    
    function speak() public pure override returns (string memory) {
        return "Meow!";
    }
    
    function purr() public pure returns (string memory) {
        return "Purring softly...";
    }
}

abstract contract Vehicle {
    string public brand;
    
    constructor(string memory _brand) {
        brand = _brand;
    }
    
    function start() public virtual pure returns (string memory);
    
    function stop() public pure returns (string memory) {
        return "Vehicle stopped";
    }
}

contract Car is Vehicle {
    uint256 public doors;
    
    constructor(string memory _brand, uint256 _doors) Vehicle(_brand) {
        doors = _doors;
    }
    
    function start() public pure override returns (string memory) {
        return "Car engine started!";
    }
    
    function honk() public pure returns (string memory) {
        return "Beep beep!";
    }
}