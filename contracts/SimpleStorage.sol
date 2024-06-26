// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; // version

contract SimpleStorage {

    uint256 public favoriteNumber;


    mapping(string => uint256) public nametoFavoriteNumber;
    People[] public people;

    struct People{
        uint256 favoriteNumber;
        string name;
    }

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber=_favoriteNumber;
    }

    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nametoFavoriteNumber[_name]=_favoriteNumber;
    }

}