//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "hardhat/console.sol";

contract Charity {
    struct Donation {
        address supporter;
        string message;
        string name;
        uint256 amount;
        uint256 timestamp;
    }

    Donation[] donations;

    address payable public owner;

    constructor() payable {
        console.log("Initializing Smart Contract...");
        owner = payable(msg.sender);
    }

    function makeDonation(
        string memory _message,
        string memory _name
    ) public payable {
        require(
            msg.sender.balance >= msg.value,
            "You don't have sufficient funds to make this donation."
        );

        donations.push(
            Donation(msg.sender, _message, _name, msg.value, block.timestamp)
        );
    }

    function getDonations() public view returns (Donation[] memory) {
        return donations;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdrawFunds() public {
        require(owner == msg.sender, "Caller is not the contract owner.");

        uint256 amount = address(this).balance;
        require(amount > 0, "You don't have sufficient funds to withdraw.");

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Withdrawal failed!");
    }
}
