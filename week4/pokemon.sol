// SPDX-License-Identifier:MIT
pragma solidity 0.8.21;

contract Pokemon {

    struct Pok {
        string name;
        uint attack;
        uint defend;
    }

    // Pok[] public poks;
    mapping(address => mapping(uint =>Pok)) public ownerPoks;
    mapping(address => uint) public ownerPokcount;

    function list()external view returns(Pok[] memory){
        Pok[] memory arr = new Pok[](ownerPokcount[msg.sender]);
        for(uint c = 0;ownerPokcount[msg.sender] > c; c++)
        {
            // Pok memory myArray = ownerPoks[msg.sender][c];
            // push 只能用在，storage裡面的array要push。 arr.push(ownerPoks[msg.sender][c]);
            arr[c] = ownerPoks[msg.sender][c];
        }

        return arr;
    }

    function create(string calldata _name) external {
        ownerPoks[msg.sender][ownerPokcount[msg.sender]] = Pok(_name,0,0);
        ownerPokcount[msg.sender]++;
    }

    function updateAttack(uint pokId) payable external {
        require(msg.value == 0.1 ether,"deposit must be than 0.1 ether.");

        bytes memory isEmpty = bytes(ownerPoks[msg.sender][pokId].name);
        require(isEmpty.length > 0,"pokemon not exist.");

        ownerPoks[msg.sender][pokId].attack += 1;
    }

    function updateDefend(uint pokId) payable external {
        require(msg.value == 0.1 ether,"deposit must be than 0.1 ether.");
        
        bytes memory isEmpty = bytes(ownerPoks[msg.sender][pokId].name);
        require(isEmpty.length > 0,"pokemon not exist.");

        ownerPoks[msg.sender][pokId].defend += 1;
    }
}