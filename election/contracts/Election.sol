pragma solidity ^0.5.0;

contract Election {
    // Model a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    //store accounts that have voted
    mapping(address => bool) public voters;
    // store candidates
    // fetch dandidates
    mapping(uint => Candidate) public candidates;
    // store condidates count
    uint public candidatesCount;

    //voted event
    event votedEvent (
        uint indexed _candidateId
    );


    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // reguiore that they haven;t voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record voter has voted
        voters[msg.sender] = true;
        
        // update candidate vote count
        candidates[_candidateId].voteCount ++;

        //trigger voted evnt
        emit votedEvent(_candidateId);
    }

}