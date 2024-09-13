// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    enum VoteType { none, yes, no }  // Add 'none' to track users who haven't voted yet

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;
    mapping(address => mapping(uint => VoteType)) public votes;

    function newProposal(address _targetAddr, bytes memory _data) external {
        Proposal memory addProposal;
        addProposal.target = _targetAddr;
        addProposal.data = _data;
        addProposal.yesCount = 0;
        addProposal.noCount = 0;
        proposals.push(addProposal);
    }

    function castVote(uint _id, bool _vote) external {
        Proposal storage result = proposals[_id];
        VoteType previousVote = votes[msg.sender][_id];

        // If the user has voted before, adjust the counts based on their previous vote
        if (previousVote == VoteType.yes) {
            result.yesCount -= 1;  // Remove the previous 'yes' vote
        } else if (previousVote == VoteType.no) {
            result.noCount -= 1;  // Remove the previous 'no' vote
        }

        // Update with the new vote
        if (_vote) {
            result.yesCount += 1;  // Increment yesCount for a 'yes' vote
            votes[msg.sender][_id] = VoteType.yes;  // Record new vote as 'yes'
        } else {
            result.noCount += 1;  // Increment noCount for a 'no' vote
            votes[msg.sender][_id] = VoteType.no;  // Record new vote as 'no'
        }
    }
}
