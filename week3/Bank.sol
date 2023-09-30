// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract Bank{
    // 主要存入ETH，而非ERC20 token，最少完成這三個方法：Deposit , Withdraw , Check Balance
    // function name 要用 camel case
    // 遇到error 輸入0.1會出現bigInt轉string相關的錯誤，只能輸入正整數。
    // 如果withdrawal裡transfer交易出錯，那整個狀態都不會執行，但還是會花手續費，sender的balance和nonce會更改。

    mapping(address => uint) public balanceOf;

    modifier checkDeposit(){
        require(msg.value > 0,"deposit must be than zero.");
        _;
    }

    modifier checkWithdraw(uint getValue){
        require(address(this).balance >= getValue,"bank is empty.");
        require(balanceOf[msg.sender] >= getValue,"you can't get too more.");
        _;
    }

    // amount可以取得總共deposit的數量。
    function deposit() checkDeposit external payable returns(uint amount){
        balanceOf[msg.sender] += msg.value;
        amount = balanceOf[msg.sender];
    }

    function withdraw(uint getValue) external checkWithdraw(getValue){
        balanceOf[msg.sender] -= getValue;
        payable(msg.sender).transfer(getValue);
    }
}