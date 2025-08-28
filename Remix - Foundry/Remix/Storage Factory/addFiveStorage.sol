// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import{ SimpleStorage } from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    // +5
    // Override
    // Virtual override
    function store(uint256 _newNumber) public override {
        myFavoriteNumber = _newNumber + 5;
    }
    
}