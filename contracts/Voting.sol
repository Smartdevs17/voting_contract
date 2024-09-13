// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }
    
    Proposal[] public proposals;

    function newProposal(address _targetAddr, bytes memory  _data) external{
        Proposal memory addProposal;
        addProposal.target = _targetAddr;
        addProposal.data = _data;
        addProposal.yesCount = 0;
        addProposal.noCount = 0;
        proposals.push(addProposal);
    }

    function castVote(uint _id, bool _vote) external {
        for(uint i; i < proposals.length; i++){
            Proposal storage result = proposals[_id];
            if(_vote){
                result.yesCount += 1;
            }else{
                result.noCount += 1;
            }
        }
    }
}
