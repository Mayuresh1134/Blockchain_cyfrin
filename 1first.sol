// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SavingsJar {
    address public immutable owner;
    uint public immutable unlockTime;

    event Deposit(address indexed sender, uint amount);
    event Withdraw(uint amount);

    // Lock duration is passed in seconds (e.g., 60 for 1 minute, 2592000 for 30 days)
    constructor(uint _lockDuration) {
        owner = msg.sender;
        unlockTime = block.timestamp + _lockDuration;
    }

    // Allows the jar to receive ETH at any time
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw all funds once the lock time has passed
    function withdraw() external {
        require(msg.sender == owner, "You are not the owner of this jar!");
        require(block.timestamp >= unlockTime, "The jar is still locked!");

        uint amount = address(this).balance;
        require(amount > 0, "Jar is empty");

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdraw(amount);
    }

    // Helper to check how much time is left in seconds
    function getTimeLeft() external view returns (uint) {
        if (block.timestamp >= unlockTime) {
            return 0;
        }
        return unlockTime - block.timestamp;
    }
}