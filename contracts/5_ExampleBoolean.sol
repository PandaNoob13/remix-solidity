//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleBoolean {
    bool private myBool;
    uint private myUint = 250;
    string private myString;
    bytes private myBytes; // Bytes has property length, while string doesn't;

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    function getMyBool() public view returns (bool) {
        return myBool;
    }

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    function decrementUint() public { 
        unchecked {
            myUint -= 251;
        }
    }

    function getMyUint() public view returns (uint) {
        return myUint;
    }

    function incrementUint() public {
        myUint++;
    }

    function setMyString(string memory _myString) public {
        myString = _myString;
    }

    function compareStrings(string memory _myString) public view returns(bool) {
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }
}