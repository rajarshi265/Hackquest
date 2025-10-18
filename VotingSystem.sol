// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VotingSystem {
    struct Proposal {
        string name;
        uint voteCount;
    }

    address public admin;
    bool public votingActive;

    Proposal[] public proposals;
    mapping(address => mapping(uint => bool)) public hasVoted; // voter => proposalId => voted

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this");
        _;
    }

    modifier votingOpen() {
        require(votingActive, "Voting is not active");
        _;
    }

    constructor(string[] memory proposalNames) {
        admin = msg.sender;
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function startVoting() external onlyAdmin {
        require(!votingActive, "Voting already active");
        votingActive = true;
    }

    function endVoting() external onlyAdmin {
        require(votingActive, "Voting not active");
        votingActive = false;
    }

    function vote(uint proposalIndex) external votingOpen {
        require(!hasVoted[msg.sender][proposalIndex], "Already voted for this proposal");
        require(proposalIndex < proposals.length, "Invalid proposal");
        
        proposals[proposalIndex].voteCount++;
        hasVoted[msg.sender][proposalIndex] = true;
    }

    function getProposalCount() external view returns (uint) {
        return proposals.length;
    }

    function getProposal(uint index) external view returns (string memory, uint) {
        Proposal memory proposal = proposals[index];
        return (proposal.name, proposal.voteCount);
    }

    function winningProposal() external view returns (string memory winnerName, uint votes) {
        uint winningVoteCount = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winnerIndex = i;
            }
        }

        winnerName = proposals[winnerIndex].name;
        votes = proposals[winnerIndex].voteCount;
    }
}