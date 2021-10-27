// SPDX-License-Identifier: MIT

/*
Account addresses                             Roles

0xca35b7d915458ef540ade6068dfe2f44e8fa733c    Chairperson and voter (weight = 2)

0x14723a09acff6d2a60dcdf7aa4aff308fddc160c    Voter (weight = 1)

0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2d     Voter (weight = 1)

0x583031d1113ad414f02576bd6afabfb302140225    Voter (weight = 1)

0xdD870fA1b7C4700F2BD7f44238821C26f7392148    Yet another voter
*/

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

  // Phase can take only 0, 1, 2, 3 values: Others invalid
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

  modifier onlyChair() {
    require(msg.sender == chairperson);
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
  function changeState(Phase phase) onlyChair public {
    require(phase > state);

    state = phase;
  }

  function register(address voter) public validPhase(Phase.Regs) onlyChair {
    require(!voters[voter].voted);

    voters[voter].weight = 1;
  }

  function vote(uint toProposal) public validPhase(Phase.Vote) {
    Voter memory sender = voters[msg.sender];

    require(!sender.voted);
    require(toProposal < proposals.length);
    
    sender.voted = true;
    sender.vote = toProposal;   
    proposals[toProposal].voteCount += sender.weight;
  }

  function requestWinner() public validPhase(Phase.Done) view returns (uint winningProposal) {
    uint winningVoteCount = 0;
      
    for (uint prop = 0; prop < proposals.length; prop++) 
      if (proposals[prop].voteCount > winningVoteCount) {
        winningVoteCount = proposals[prop].voteCount;
        winningProposal = prop;
      }
     
    assert(winningVoteCount >= 3);
  } 
}