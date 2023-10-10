// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract TradingCenter{

    mapping(address => uint256) private balanceOf;

    IERC20 immutable bcToken;

    constructor(address bcTokenAddress) {
        bcToken = IERC20(bcTokenAddress);
    }

    
    function deposit(uint256 amount) external{
        require(amount <= bcToken.allowance(msg.sender,address(this)),"bc Token approving amount isn't enough.");
        balanceOf[msg.sender] += amount;
        bcToken.transferFrom(msg.sender,address(this),amount);
    }

    function exchange(address token, uint256 amount) external{
        IERC20 swapToken= IERC20(token);
        require(amount <= swapToken.allowance(msg.sender,address(this)),"Jim wETH approving amount isn't enough.");
        require(amount <= bcToken.balanceOf(msg.sender),"TradingCenter's bc token amount isn't enough.");
        swapToken.transferFrom(msg.sender,address(this),amount);
        bcToken.transfer(msg.sender,amount);
    }

    // deposite bc 有多少，就算被換掉還是會紀錄原本數量。
    function getDepositAmount() external view returns (uint256){
        return balanceOf[msg.sender];
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}