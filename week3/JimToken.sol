// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract JimToken is ERC20 {
    constructor() ERC20("Jim Token", "JT") {
        // 因為是算個數 但單位一樣適用wei eth 來計算，所以需要用挖的數量乘 10^18
       _mint(msg.sender, 100 * 10 ** uint(decimals()));
       // _mint(msg.sender, 100);
    }
}
