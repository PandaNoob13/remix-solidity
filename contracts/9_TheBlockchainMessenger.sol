//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract TheBlockchainMessenger {

    uint public changeCounter;
    uint public lastValueSent;
    address public owner;
    string public theMessage;
    string public lastFunctionCalled;
    Singleton public singleton;

    uint public myUint;

    function setMyUint(uint _myNewUint) public {
        myUint = _myNewUint;
    }


    constructor() {
        owner = msg.sender;
        lastFunctionCalled = "nil";
        singleton = new Singleton();

    }

    function updateTheMessage(string memory _newMessage) public payable {
        if (msg.sender == owner) {
            if(msg.value == 1 ether) {
                theMessage = _newMessage;
                changeCounter++;
            } else {
                if (msg.value > 1 ether) {
                    payable(msg.sender).transfer(msg.value - 1 ether);
                } else {
                    payable(msg.sender).transfer(msg.value);
                }
            }
        }
    }

    function getSingletonOwner() public view returns (address) {
        return singleton.getOwner();
    }

    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    fallback() external {
        // lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
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
 //0x893d20e8
 //0x893d20e8 2e7de4dc20ab2c04d17aa0699b89c86c9cd36ed761f937e212e0018a