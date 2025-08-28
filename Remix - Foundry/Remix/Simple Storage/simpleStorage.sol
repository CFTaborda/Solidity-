// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleStorage {
    // bool hasFavoritNumber = false;
    // uint favoritNumber = 45; // uint work betwen 8-256
    // string favoritName = "John";
    // address owner = msg.sender;
    // bytes32 bytes32Data = "John"; // bytes work betwen 2-32
    // int intData = 10; // int work betwen 8-256

    // favoriteNumber get initialized in 0, if I don't give a number
    uint256 public myFavoriteNumber;

    // Structs allow to create more complicated data types that have multiple properties.
    // They are useful for grouping together related data.
    struct Person {
        uint256 _favoriteNumber;
        string _name;
    }

    // Person public pat = Person(12, "Pat");
    // Person public person = Person({favoriteNumber: 7, name: "John"}); // Both are the same way to write a list

    // Arrays
    // [] empty is a dinamic Array // [int number] with a number inside is a static Array
    Person[] public listOfPeople;

    // Easy way to find parameters
    mapping(string => uint256) public nameToFavoriteNumber;
    mapping(uint256 => string) public favoriteNumberToName;


    function store(uint _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }

    // view or pure
    function retrieve() public view returns(uint256) {
        return myFavoriteNumber;
    }

    // temporary (calldata [can not be modifier], memory [can be modifier]); storage (permanent and can be modifier)
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // Person memory newPerson = Person(_favoriteNumber, _name);
        listOfPeople.push(Person(_favoriteNumber, _name)); // This maner to write is better because we don't need to create a new variable
        nameToFavoriteNumber[_name] = _favoriteNumber;
        favoriteNumberToName[_favoriteNumber] = _name;
    }
}