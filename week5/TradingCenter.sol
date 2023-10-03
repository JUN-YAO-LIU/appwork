// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

// import "https://gist.github.com/d49976110/ea6645a8977e4d25eda7474446296df1";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// 通常支援幣種我看都是寫死在合約裡，有動態的做法？

contract TradingCenter{

    IERC20 immutable bcToken;

    constructor(address bcTokenAddress) {
        bcToken = IERC20(bcTokenAddress);
    }

    function deposit(uint256 amount) external{
        require(amount <= bcToken.allowance(msg.sender,address(this)),"approving amount is too few.");
        bcToken.transferFrom(msg.sender,address(this),amount);
    }

    function exchange(address token, uint256 amount) external{
        IERC20 swapToken= IERC20(token);
        require(amount <= swapToken.allowance(msg.sender,address(this)),"approving amount is too few.");
        require(amount <= bcToken.balanceOf(msg.sender),"TradingCenter isn't enough.");
        swapToken.transferFrom(msg.sender,address(this),amount);
        bcToken.transfer(msg.sender,amount);
    }

    function getDepositAmount() external view returns (uint256){
        return bcToken.balanceOf(msg.sender);
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