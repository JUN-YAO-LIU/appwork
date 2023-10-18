// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract RevAndFallback{

    event Log(string func);
    bytes public msgData;

    fallback() external payable {
        msgData = msg.data;
        emit Log("fallback");
    }

    receive() external payable {
        emit Log("receive");
    }

    // 有fallback 存在msg.data不會為空，所以不會執行到。
    function testCalldata()external{
        msgData = msg.data;
        emit Log("testCalldata");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Fallback{

    // 會跳出警示，沒有receive。
    fallback() external payable {
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract TestFallbackAndRecieve {

    bytes public b;
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function callDataTest(address to) external {
        bytes memory selector = abi.encodeWithSignature("testCalldata()");
        b = selector;
        (bool success, ) = to.call(selector);
        require(success);
    }
}