//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Storage {

    uint256 favNumber;

    function store(uint256 _favNum) public {

        favNumber = _favNum;
    }
    
}