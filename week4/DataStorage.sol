// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract StoregeTest {

    // uint storage public s = 1;

    // uint memory public m = 1;

    bytes public _bytes = bytes("0x01") ;

    function loadStorage() public returns (bytes memory) 
    {
        return _bytes;
    }

    function loadMemory(bytes memory _m) public returns (bytes memory)
    {
        return _m;
    }

    function loadCalldata(bytes calldata _calldata) public returns (bytes memory)
    {
        return _calldata;
    }

}

// 這邊要看gas知道花費多少。
// 22670 calldata
// 22990 memory
// 24461 storage 宣告一定是state variable
// return 只能是memory，function 要return值會從function裏面。透過opcode去拿。
// compile 底層的opcode會有相對應的變化