//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleViewPure {
    uint private myStorageVariable;

    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable;
    }

    function setMyStorageVariable(uint _newVar) public {
        myStorageVariable = _newVar;
    }

    function getAddition(uint a, uint b) public pure returns(uint) {
        return a+b; // cannot access any variable inside this class, only other pure functions;
    }
}