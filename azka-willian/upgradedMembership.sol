// SPDX-License-Identifier: GPL 3.0
pragma solidity ^0.8.23;

contract membershipSystem{
    uint Id = 1;
    enum Type{
        notAMember,
        follower,
        influencer
    }
    string si = "w" ;
    error bukanOwner();
    struct Member {
        string name;
        Type types;
        uint memberId;
    }
    
    mapping(address => Member) private members;
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }

    function addMember(string memory n, Type _types) external{
        members[msg.sender] = Member(n, _types, Id++);
    }

    function changeName(string memory _name) external {
        // member[msg.sender].name = _name;
        // member[msg.sender].types = _types;
        // member[_add].status = stat; 
        Member storage member = members[msg.sender];
        member.name = _name;

    }

    function adjustStatus(Type _types, address _add) external onlyOwner{
        //if(owner != msg.sender) revert bukanOwner();
        Member storage member = members[_add];
        member.types = _types;
    }

    function checkMember (address _add) external onlyOwner view returns(Member memory){
        //if(owner != msg.sender) revert bukanOwner();
        return members[_add];
    }

    function deleteMember(address _add) external onlyOwner {
        //if(owner != msg.sender) revert bukanOwner();
        delete members[_add];
    }

    modifier onlyOwner(){
        if(owner != msg.sender) revert bukanOwner();
        _;
    }

    // function check(string memory s) external{
    //     s = "pba";
    //     si = s;
    // }
    
}