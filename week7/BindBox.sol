// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/*totalSupply: 500
mint(): 隨機 mint tokenId
隨機的方式有以下選擇方式
自己製作隨機 random，不限任何方法
Chainlink VRF
RANDAO
Implement 盲盒機制
*/
/*
0.insert the array[500] and value
1.get random 
2.find the array index value
3.pop this value and remove this array.
*/


contract BindBox is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint16 public constant totalSupply = 500;

    string constant public blockUrl = "";

    string constant public baseUri = '{image:"https://imgur.com/IBDi02f"}';

    constructor() ERC721("bind box", "BBX") {
    }
   
    function mint() external {
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        _tokenIds.increment();
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return baseUri;
    }

    function getRandom() external returns(uint){

    }
}