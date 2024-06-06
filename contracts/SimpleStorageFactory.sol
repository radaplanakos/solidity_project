// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; // version

import "./SimpleStorage.sol"; 

contract StorageFactory{
    SimpleStorage public simplestorage;

    function createSimpleStorageContract() public {
        simplestorage= new SimpleStorage();
    }

}
