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

    function testABIDecode(bytes calldata data) external pure returns (string memory arr,uint256 u,address a) {
      (arr,u,a) = abi.decode(data, (string,uint256,address));
    }

    function encodeWithSignature(
        address to,
        uint amount
    ) external pure returns (bytes memory) {
        // Typo is not checked - "transfer(address, uint)"
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    function encodeWithSelector(
        address to,
        uint amount
    ) external pure returns (bytes memory) {
        // Type is not checked - (IERC20.transfer.selector, true, amount)
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    function encodeCall(address to, uint amount) external pure returns (bytes memory) {
        // Typo and type errors will not compile
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }

    // true [9,18],0x2Ff1F4e5D08a822743ec6b342c521A0a421456cb,Brian
     function encodeWithSignatureAppWorks(
      bool b,
      uint256[] calldata arrUint,
      address a,
      string calldata array) 
      external pure returns (bytes memory) {
        return abi.encodeWithSignature("AppWorks(bool,uint256[],address,string)", b, arrUint,a,array);
    }

     function AppWorks(
      bool b,
      uint256[] calldata arrUint,
      address a,
      string calldata array) 
      external pure returns(bool){
        require(b,"bool parameter correct.");
        require(arrUint[0] == 9,"uint array parameter correct.");
        require(arrUint[1] == 18,"uint array parameter correct.");
        require(a == 0x2Ff1F4e5D08a822743ec6b342c521A0a421456cb,"address parameter correct.");
        require(keccak256(abi.encodePacked((array))) == keccak256(abi.encodePacked(("Brian"))),"string parameter correct.");

        return true;
    }

   

    function encodeWithSignatureSchool() 
      external pure returns (bytes memory) {
        return abi.encodeWithSignature("School(string[])", ["11","2","3"]);
    }

     function encodeFunSelector(string memory s) external pure returns (bytes memory) {
      return abi.encodeWithSignature(s);
    }

    fallback() external payable {
    }


  //  function watch_tg_invmru_119a5a98(address,uint256,uint256)public{}

  //  function passphrase_calculate_transfer(uint64,address)public{}

  //  function branch_passphrase_public(uint256,bytes8) public{}
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

