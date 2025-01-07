//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract TheBlockchainMessenger {

    uint public changeCounter;

    address public owner;

    string public theMessage;

    address[] private contracts;

    constructor() {
        owner = msg.sender;
    }

    function updateTheMessage(string memory _newMessage) public {
        if (msg.sender == owner) {
            theMessage = _newMessage;
            changeCounter++;
        }
    }

    function createContract() public {
        address newContract = address(new Singleton());
        contracts.push(newContract);
    }

}

contract Singleton {

    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

}
