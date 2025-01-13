//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

import "./2_Owner.sol";

// Error Messages
string constant notAuthorized = "You are not authorized to use this feature!";
string constant hasVotedPreviously = "You have voted previously!";
string constant insufficientBalance = "Insufficient balance.";
string constant failedFallback = "Function call is not successful. Process aborted.";

// Helps map ID with address, for reset purpose
struct MappingCount {
    uint numberOfGuardians;
    uint numberOfNewOwnerCandidates;
}

// Mark guardian as valid if initiated from constructor parameter, and mark as hasVoted if guardian has voted for a new owner
struct Guardian {
    bool isValid;
    bool hasVoted;
    uint allowance;
}

contract FinalSmartContractImplementation is Owner {
    mapping(address => Guardian) private guardians;
    mapping(uint => address) private guardianAddresses;

    mapping(address => uint) private newOwnerVotes;
    mapping(uint => address) private newOwnerAddresses;
    MappingCount private mappingCount;

    constructor(address[] memory _guardians, uint _guardianAllowance) {
        setupGuardians(_guardians, _guardianAllowance);
    }

    receive() external payable { }
    fallback() external payable { }

    function setupGuardians(address[] memory _guardians, uint _guardianAllowance) private {
        mappingCount.numberOfGuardians = _guardians.length;
        for (uint i=0; i<mappingCount.numberOfGuardians; i++) {
            guardians[_guardians[i]] = Guardian(true, false, _guardianAllowance);
            guardianAddresses[i] = _guardians[i];
        }
    }

    function senderIsOwner() private view returns (bool) {
        return address(this) == this.getOwner();
    }

    function senderIsGuardian() private view returns (bool) {
        return guardians[msg.sender].isValid;
    }

    modifier proofOfReserve(uint _value) {
        bool authorizedPerson = senderIsOwner() || senderIsGuardian();
        require(authorizedPerson, notAuthorized);
        require(address(this).balance >= _value, insufficientBalance);
        if(senderIsGuardian()) { 
            require(guardians[msg.sender].allowance >= _value, insufficientBalance);
            guardians[msg.sender].allowance -= _value; 
        }
        _;
    }

    function withdraw(uint _value) public payable proofOfReserve(_value) {
        payable(msg.sender).transfer(_value);  

    }

    function sendToAddress(address payable _receiver, uint _value, bytes memory _payload) public proofOfReserve(_value) returns (bytes memory) {
        (bool success, bytes memory returnData) = _receiver.call{value: _value}(_payload);
        require(success, failedFallback);
        return returnData;
    }

    function checkContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function addSpendingLimit(address _guardian, uint _value) public {
        require(senderIsOwner(), notAuthorized);
        guardians[_guardian].allowance += _value;
    }

    function voteNewOwner(address _newOwner) public {
        require(senderIsGuardian(), notAuthorized);
        require(guardians[msg.sender].hasVoted, hasVotedPreviously);
        guardians[msg.sender].hasVoted = true;

        newOwnerVotes[_newOwner]++;
        newOwnerAddresses[mappingCount.numberOfNewOwnerCandidates] = _newOwner;
        mappingCount.numberOfNewOwnerCandidates++;

        if (newOwnerVotes[_newOwner] >= 3) {
            changeOwner(_newOwner);
            resetVoteData();
        }
    }

    function resetVoteData() private {
        for (uint8 i=0; i<mappingCount.numberOfGuardians; i++) {
            guardians[guardianAddresses[i]].hasVoted = false;
        }

        for (uint i=0; i<mappingCount.numberOfNewOwnerCandidates; i++) {
             newOwnerVotes[newOwnerAddresses[i]] = 0;
        }

        mappingCount.numberOfNewOwnerCandidates = 0;
    }
 
}
