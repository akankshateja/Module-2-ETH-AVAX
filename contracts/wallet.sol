// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract wallet {
    address payable public owner;
    uint256 public balance;

    event Deposit(address indexed depositor, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);

    constructor(uint256 initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function deposit(uint256 _amount) public payable onlyOwner {
        uint256 previousBalance = balance;
        
        // Ensure the deposit amount is not negative
        require(_amount > 0, "Deposit amount must be greater than zero");

        balance += _amount;

        // Use require instead of assert to check balance update
        require(balance == previousBalance + _amount, "Deposit failed");

        emit Deposit(msg.sender, _amount);
    }

    function withdraw(uint256 _withdrawAmount) public onlyOwner {
        uint256 previousBalance = balance;
        
        // Ensure the withdrawal amount is not negative and doesn't exceed the balance
        require(_withdrawAmount > 0, "Withdrawal amount must be greater than zero");
        require(balance >= _withdrawAmount, "Insufficient balance");

        balance -= _withdrawAmount;

        // Use require instead of assert to check balance update
        require(balance == previousBalance - _withdrawAmount, "Withdrawal failed");

        emit Withdraw(msg.sender, _withdrawAmount);
    }
}
