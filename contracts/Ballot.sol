// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Ballot {
    struct Voter {
        uint256 weight;
        bool voted;
        uint256 vote;
    }

    struct Proposal {
        uint256 voteCount;
    }

    address chairperson;

    mapping(address => Voter) voters;

    Proposal[] proposals;

    // Phase can take only 0,1,2,3 values: Others invalid
    enum Phase {
        Init,
        Regs,
        Vote,
        Done
    }

    Phase public state = Phase.Init;

    // modifiers
    modifier validPhase(Phase phase) { 
      require(state == phase); 
      _; 
    } 

    constructor(uint numProposals) {
        chairperson = msg.sender;
        voters[chairperson].weight = 2; // weight 2 for testing purposes

        for (uint prop = 0; prop < numProposals; prop++)
            proposals.push(Proposal(0));

        state = Phase.Regs;
    }

    // function for changing Phase: can be done only by chairperson
    function changeState(Phase x) public {
       if (msg.sender != chairperson) {
         revert();
       }

       if (x < state)
        revert();

       state = x;
    }

    function register(address voter) public validPhase(Phase.Regs) {
        if (msg.sender != chairperson || voters[voter].voted)
          revert();

        voters[voter].weight = 1;
        voters[voter].voted = false;
    }

    function vote(uint toProposal) public validPhase(Phase.Vote) {
        Voter memory sender = voters[msg.sender];

        if (sender.voted || toProposal >= proposals.length)
          revert();

        sender.voted = true;
        sender.vote = toProposal;   
        proposals[toProposal].voteCount += sender.weight;
    }

    function reqWinner() public validPhase(Phase.Done) view returns (uint winningProposal) {
        uint winningVoteCount = 0;
        
        for (uint prop = 0; prop < proposals.length; prop++) 
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                winningProposal = prop;
            }
       
    } 
}