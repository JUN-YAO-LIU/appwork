// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract ValueTypes {
    bool public b = true;

    uint public u = 123; // uint = uint256
    uint256 public u256 = 256;
    uint16 public u16 = 16;
    uint8 public u8 = 128;

    int public i = 256;
    int256 public i256 = 256; // int = int256
    int128 public i128 = 16;
   
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public myAddress = 0xc8Bd59d60961bEdb12c95079250d3075b9328a2d;// 20bytes
    bytes32 public b32 = 0x0123456789012345678901234567890123456789012345678901234567890123;// 64bytes
}