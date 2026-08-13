//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

contract SimpleStorage {

    bool mybool = True;
    uint256 favnum = 34;
    int256 favnum1 = -32;
    string favnumIntext = "thirty-two";
    address newaddress = "23nkjsndfsdhjflj";
    bytes32 newbyte = "cat";
    bytes1 minBytes = "I am a fixed size byte array of 1 byte";
    bytes32 maxBytes = "I am a fixed size byte array of 32 bytes"; //bytes can be alloted in size upto 32
    bytes dynamicBytes = "I am a dynamic array, so you can manipulate my size"; //strings are internally represented as dynamic bytes

    // every variable type in solidity has a default value like for uint it is 0 and for bool it is false.
}