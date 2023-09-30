// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.4;

contract Bytes{

    bytes public bys ; 
    bytes1 public bys1 ; 
    bytes32 public bys32;


    function pushBys() external {
        // 一次只能push一個byte。
        bys.push(0x01);
    }

    function getBys() external view returns(bytes memory){
        return bys;
    }

    function setBys1() external {
        bys1 = 0x02;
    }

    function setBys32() external {
        bys32 = bytes32(uint(0x01));
    }
}