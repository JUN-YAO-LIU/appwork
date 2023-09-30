// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract Counter{
    uint public c = 0; 
    string public s; 

    constructor(){
        s = "hi";
    }

    function AddNum() external returns(uint a){
        c++;
        a = c;
    }
}