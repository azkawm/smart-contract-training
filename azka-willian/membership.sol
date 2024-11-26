// SPDX-License-Identifier: GPL 3.0
pragma solidity ^0.8.23;

contract membersshipSystem{
    mapping(address => bool) private members;
    address public owner;
    error harusOwner();

    constructor() {
        owner = msg.sender;
    }

    function addmembers(address _add) external{
        if(owner != msg.sender) revert harusOwner();
        members[_add] = true;
    }

    function removemembers(address _add)external{
        if(owner != msg.sender) revert harusOwner();
        members[_add] = false;
    }

    function ismembers(address _add)external view returns(bool){
        if(owner != msg.sender) revert harusOwner();
        return members[_add];
    }

}

