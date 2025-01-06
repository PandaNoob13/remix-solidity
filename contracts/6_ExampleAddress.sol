//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleAddress {
    address public someAddress;

    function getAddressBalance() public view returns(uint) {
        return someAddress.balance;
    }

    function updateSomeAddress() public {
        someAddress = msg.sender;
    }
}