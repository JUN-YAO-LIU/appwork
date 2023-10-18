// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract TestSlot {
    // uint / 8 看看幾 byte
    // 256 / 8 -> 32 -> 所以有64位。
    // 128 / 8 -> 16
    // address -> 20
    // 要看上一個，剩餘的空間這一個能不能存。
    // 還有offset。
    enum Case1 { ONE, TWO, THREE }
    enum Case2 { ONE, TWO, THREE, FOUR }
    enum Case3 { ONE, TWO, THREE, FOUR, onw, two, three,four }

    
    uint256 public number1;
    uint128 public number2;
    uint256 constant  public number3 = 1000;
    address public owner ; 
    uint8   public number4;
    bytes8  public b8 = bytes8("0x08");
    address public sender;
    bytes12 public b12 = bytes12("0x12");
    bytes32 public b32 = bytes32("0x32");
    Case1   public case1;
    Case2   public case2;
    Case3   public case3;

    // 2 ^ 8 - 1 
    constructor(uint256 _number1 , uint128 _number2, uint8 _number4){
        number1 = _number1;
        number2 = _number2;
        owner = msg.sender;
        number4 = _number4;
        sender = msg.sender;
    }

   // constant 不會存在slot鏈上
   // 可以在remix上直接看到，slot的位置。
}