pragma solidity 0.5.16;

contract Auth{
   int votes;
   string party;

    constructor() public {
        votes = 0;
    }

    function getVotes() view public returns(int){
        return votes;
    }
    function getParty() view public returns(string memory){
        return party;
    }

    function vote(bool hasAuth, string memory partyName ) public {
        if(hasAuth == true){      
            votes = votes + 1;
            party = partyName;
        }
    }
}