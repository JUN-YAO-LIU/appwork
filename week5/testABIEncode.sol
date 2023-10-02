// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract TestEncode {

    function encode() external pure returns (bytes memory) {
      return abi.encode("appworks",1,0x2Ff1F4e5D08a822743ec6b342c521A0a421456cb);
    }

    function encodeAppworks() external pure returns (bytes memory) {
      return abi.encode("appworks");
    }
      // 陣列是動態，會出現在左邊（固定address都會放右邊），最一開始會先說位置在哪。
      // string 會是bytes array的形式
      //0000000000000000000000000000000000000000000000000000000000000020 位置 16進制 -> 16 * 2 / 32
      //0000000000000000000000000000000000000000000000000000000000000008 -> 1 陣列長度是多少（字串）要讀多少byte。
      //617070776f726b73000000000000000000000000000000000000000000000000 -> 2 ASICC 編碼

    function encodePackedAppworks() external pure returns (bytes memory) {
      return abi.encodePacked("appworks");
    }

    function encodePackedAppworksV2() external pure returns (bytes memory) {
      return abi.encode("appworks",1,99,"jim");
// 0000000000000000000000000000000000000000000000000000000000000080 -> array 的記憶體位置，會按照順序去排。
// 0000000000000000000000000000000000000000000000000000000000000001
// 0000000000000000000000000000000000000000000000000000000000000063 -> 99
// 00000000000000000000000000000000000000000000000000000000000000c0
// 0000000000000000000000000000000000000000000000000000000000000008
// 617070776f726b73000000000000000000000000000000000000000000000000
// 0000000000000000000000000000000000000000000000000000000000000003
// 6a696d0000000000000000000000000000000000000000000000000000000000
    }

    function encodeOne() external pure returns (bytes memory) {
      return abi.encode(1);
    }

    function encodeAddress() external pure returns (bytes memory) {
      return abi.encode(0x2Ff1F4e5D08a822743ec6b342c521A0a421456cb);
    }

    // function School(string[] calldata array){

    // }

    function testABIDecode(bytes calldata data) external pure returns (string memory arr,uint256 u,address a) {
      (arr,u,a) = abi.decode(data, (string,uint256,address));
    }

}

