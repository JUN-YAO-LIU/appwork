// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract CounterV2{
    uint public c = 0; 
    string public s; 

    constructor(){
        s = "hi";
    }

    // 一般external payable會是這樣的順序
    // gwei wei 也是可以用的單位
    function AddNum() external payable {
        require(msg.value == 0.001 ether ,"bank is empty.");
        c++;
    }

    function Withdraw() external {
        address payable receiver = payable(msg.sender);
        receiver.transfer(address(this).balance);
    }
}