// SPDX-License-Identifier: GPL 3.0
pragma solidity ^0.8.0;

contract votingSystem{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    //voter   
    mapping(address=>bool) voteOnce; //add
    uint public count = 0;
    event voted(address, string);
    //candidate
    //mapping(address=>Candidate) public candidates;
    mapping(uint=>Candidate) public candidateId;
    struct Candidate{
        string name;
        uint voteCount;
        bool valid;
    }
    uint[] candidateIds;
    uint[] public winnerIds;
    uint Id;
    event winner(Candidate);
     //Candidate[id][] public ID;
    
    function addCandidate( string memory n) external{
        require(msg.sender == owner, "Not Authorized");
        candidateId[Id++] = Candidate(n, 0, true);
        candidateIds.push(Id);
    }

    function vote(uint _Id) external returns(bool){
        require(voteOnce[msg.sender] != true, "You have Voted");
        candidateId[_Id].voteCount++;
        count++;
        emit voted(msg.sender, "Voted");
        return voteOnce[msg.sender] = true;
    }

    function result() public returns(Candidate memory){
        require(msg.sender == owner, "Not Authorized");
        uint highestVote = 0;
        uint idWinner;
        for(uint i = 0; i <= candidateIds.length; i++){
            if(candidateId[i].voteCount > highestVote && candidateId[i].voteCount != highestVote){
                highestVote = candidateId[i].voteCount;
                idWinner = i;
            }else if(candidateId[i].voteCount == highestVote){
                winnerIds.push(i); 
            }
        }
        emit winner(candidateId[idWinner]);

        return candidateId[idWinner];
    }

    function seeWinnersArr() external view returns(uint[] memory){
        return winnerIds;
    }


}