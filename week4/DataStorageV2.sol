// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract StoregeTest {

    bytes public public_bytes = bytes("0x01") ;

    function loadStorage() public returns (bytes memory) 
    {
        return public_bytes;
    }

    function loadMemory(bytes memory _byte) public returns (bytes memory)
    {
        return _byte;
    }

    function loadCalldata(bytes calldata _calldata) public returns (bytes memory)
    {
        return msg.data;
    }
}

// 這邊要看gas知道花費多少。
// 22670 calldata
// 22990 memory
// 24461 storage 宣告一定是state variable
// return 只能是memory，function 要return值會從function裏面。透過opcode去拿。