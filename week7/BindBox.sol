// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract PuPuERC721 is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string constant public baseUri = '{image:"https://imgur.com/IBDi02f"}';

    // 1.create a ERC721 token with name and sybmol.
    constructor() ERC721("Don't send NFT to me", "NONFT") {}
   
    // 2.Have the mint function to mint a new token
    function mint(address to) external {
        uint256 newItemId = _tokenIds.current();
        _safeMint(to, newItemId);
        _tokenIds.increment();
    }

    // 3. The NFT Image is always the same,
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return baseUri;
    }
}


contract ReturnPuPuERC721 is IERC721Receiver,PuPuERC721 {

    address public who;
    address public pupuAddr;

    constructor(address checkERC721){
        pupuAddr = checkERC721;
    }

    // 1.user will transfer the ERC721 to this contract.
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4){
        who = msg.sender;
        
        // 2.check the sender(ERC721 contract) is the same as your ERC721.
        // 3.if not, please transfer this token back to the sender.
        if(msg.sender != pupuAddr){
            ERC721 token = ERC721(operator);
            token.transferFrom(address(this), from, tokenId);

            // 4.and then,mint your token to this sender.
            PuPuERC721 pu = PuPuERC721(pupuAddr);
            pu.mint(from);
        }

        // 測試require就會roll back.
        // require(msg.sender == pupuAddr,"Please don't transfer this NFT to me.");
    }
}