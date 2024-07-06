// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public owner;
    uint256 public balance;

    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);

    struct Transaction {
        address user;
        uint256 amount;
        bool isDeposit;
    }

    Transaction[] public transactionHistory;

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns(uint256) {
        return balance;
    }

    function getTransactionCount() public view returns(uint256) {
        return transactionHistory.length;
    }

    function deposit(uint256 _amount) public payable {
        require(msg.sender == owner, "You are not the owner of this account");
        balance += _amount;
        transactionHistory.push(Transaction(msg.sender, _amount, true));
        emit Deposit(msg.sender, _amount);
    }

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        require(balance >= _withdrawAmount, "Insufficient balance");
        balance -= _withdrawAmount;
        transactionHistory.push(Transaction(msg.sender, _withdrawAmount, false));
        emit Withdraw(msg.sender, _withdrawAmount);
    }
}
