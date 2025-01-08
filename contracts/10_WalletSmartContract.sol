//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract WalletSmartContract {

    mapping(address => Balance) private accounts;

    function deposit() public payable {
        Transaction memory transaction = Transaction(msg.value, block.timestamp);
        accounts[msg.sender].totalBalance += transaction.amount;
        accounts[msg.sender].numberOfDeposits++;
        accounts[msg.sender].mappingDeposits[accounts[msg.sender].numberOfDeposits] = transaction;
    }

    function withdraw(uint _value) public payable{
        require((accounts[msg.sender].totalBalance >= _value), "Insufficient Balance");

        Transaction memory transaction = Transaction(_value, block.timestamp);
        accounts[msg.sender].totalBalance -= transaction.amount;
        accounts[msg.sender].numberOfWithdrawals++;
        accounts[msg.sender].mappingWithdrawals[accounts[msg.sender].numberOfWithdrawals] = transaction;
        payable(msg.sender).transfer(_value);
        
    }

    function sendToAddress(address _receiver, uint _value) public {
        require((accounts[msg.sender].totalBalance >= _value), "Insufficient Balance");

        Transaction memory transaction = Transaction(_value, block.timestamp);
        accounts[msg.sender].totalBalance -= transaction.amount;
        accounts[msg.sender].numberOfTransfers++;
        accounts[msg.sender].mappingTransfers[accounts[msg.sender].numberOfTransfers] = transaction;

        accounts[_receiver].totalBalance += transaction.amount;
        accounts[_receiver].numberOfReceivals++;
        accounts[_receiver].mappingReceivals[accounts[_receiver].numberOfReceivals] = transaction;
    }
    
    function checkAccountBalance() public view returns (uint) {
        return accounts[msg.sender].totalBalance;
    }

    function checkContractBalance() public view returns (uint) {
        return address(this).balance;
    }

}

struct Balance {
    uint totalBalance;

    uint numberOfDeposits;
    mapping(uint => Transaction) mappingDeposits;
    uint numberOfWithdrawals;
    mapping(uint => Transaction) mappingWithdrawals;

    uint numberOfTransfers;
    mapping(uint => Transaction) mappingTransfers;
    uint numberOfReceivals;
    mapping(uint => Transaction) mappingReceivals;
}

struct Transaction {
    uint amount;
    uint timeStamp;
}