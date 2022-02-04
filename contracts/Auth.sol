pragma solidity 0.5.16;

contract Auth {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }
    struct Proposal {
        string name;
        int256 voteCount;
    }
    Proposal[] public proposals;

    mapping(address => bool) public voters;
    mapping(uint256 => Candidate) public candidates;
    uint256 public candidatesCount;

    function addCandidate(string memory _name) public {
        candidatesCount++;
        proposals.push(Proposal({name: _name, voteCount: 0}));
    }

    function vote(uint256 _candidateId) external {
        if (_candidateId > 0 && _candidateId <= candidatesCount) {
            proposals[_candidateId].voteCount++;
        }
    }

    function winningProposal() public view returns (uint256 winningProposals_) {
        int winningVoteCount = 0;
        for (uint256 p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposals_ = p;
            }
        }
    }

    function winnerName() external view returns (string memory winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }
}
