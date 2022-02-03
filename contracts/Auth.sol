pragma solidity 0.5.16;

contract Auth {
    
    struct Candidate {
        uint   id;
        string name;
        uint   voteCount;
    }
  struct Proposal {
        string name;   // short name (up to 32 bytes)
        int voteCount; // number of accumulated votes
    }
 Proposal[] public proposals;

    mapping(address => bool) public voters;
    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;    
    
    // voted event
    event votedEvent (
        uint indexed _candidateId
        );
    function addCandidate(string memory _name) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
		proposals.push(Proposal({name: _name, voteCount:0}));
    }

    function vote (uint _candidateId) public {
        require(!voters[msg.sender]);

        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount ++;
        emit votedEvent(_candidateId);
    }

    function winningProposal() public view returns (uint256 winningProposals_) {
        int  winningVoteCount = 0;
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