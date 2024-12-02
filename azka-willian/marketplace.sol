// SPDX-License-Identifier: GPL 3.0

pragma solidity ^0.8.0;

contract marketplace{

    address payable public owner;
    address payable public contractAddr;
    
    struct Item{
        uint id;
        string name;
        uint price;
        address payable seller;
        address payable owner;
        bool status;
    }
    struct User{
        uint[] id;
    }
    mapping(uint=>Item) public itemLists;
    mapping(address=>User) UserAssets;
    uint counter;

    event Listing(address, Item);
    event purchase(address, Item);
    event withdrawal(address, uint);

    receive() external payable { }

    constructor(){
        owner = payable(msg.sender);
        contractAddr = payable(address(this));

    }

    error InvalidAmount();
    error InvalidAddress();

    function listingItems(string memory n, uint p) external{
        counter++;
        itemLists[counter]=Item(counter, n, p, payable(msg.sender), payable(address(0)),false);
    }

    function purchaseItems(uint id) external payable{
        if(msg.value == itemLists[id].price){
            contractAddr.transfer(msg.value);
            itemLists[id].owner = payable(msg.sender);
            itemLists[id].status = true;
            emit purchase(msg.sender, itemLists[id]);
        }else{
            revert InvalidAmount();
        }
    }

    function withdrawFunds(uint id) external payable returns(bool){
        if(msg.sender == itemLists[id].seller){
            return payable(msg.sender).send(itemLists[id].price);
            emit withdrawal(msg.sender, itemLists[id].price);
        }else{
            revert InvalidAddress();
        }
    }
}