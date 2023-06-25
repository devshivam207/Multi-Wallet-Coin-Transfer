// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinContract {
    string public name = "Russian";
    string public symbol = "RSN";
    mapping(address => uint256) balances;
    address owner;

    constructor() {
        owner = msg.sender;
        balances[owner] = 5000;
    }

    function getBalance(address wallet) public view returns (uint256) {
        return balances[wallet];
    }

    function transfer(address[] memory wallets, uint256[] memory amounts) public {
        require(wallets.length == amounts.length, "Invalid input");

        uint256 totalAmount = 0;
        for (uint256 i = 0; i < wallets.length; i++) {
            require(amounts[i] > 0, "Invalid amount");
            require(balances[msg.sender] >= amounts[i], "Insufficient balance");

            balances[msg.sender] -= amounts[i];
            balances[wallets[i]] += amounts[i];
            totalAmount += amounts[i];
        }

        emit Transfer(msg.sender, wallets, amounts, totalAmount);
    }

    event Transfer(address indexed from, address[] indexed to, uint256[] amounts, uint256 totalAmount);
}
