// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract StateVariables {
    uint public myUint = 123;
    
    function foo()  external {
        myUint = 10;
    }
}