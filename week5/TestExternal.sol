// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract TestExternal{

    IERC20 token;
    address public sender;

    constructor(address bcTokenAddress) {
     token = IERC20(bcTokenAddress);
    }

    function testCallExternal(uint m) external {
        sender = msg.sender;
        token.transferFrom(msg.sender,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,m);
    }

    function testCallExternalSelf(address bcTokenAddress,uint m) external {
        sender = msg.sender;
        IERC20 token =  IERC20(bcTokenAddress);
        token.transferFrom(msg.sender,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,m);
    }

      function encodeWithSignature(
        address to,
        uint amount
    ) external pure returns (bytes memory) {
        // Typo is not checked - "transfer(address, uint)"
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
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