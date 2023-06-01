// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract GarageManager {

    mapping(address => Car[]) public garage;

    /*
    A public mapping called garage to store a list of Cars (described below), 
    indexed by address
    Add the following types and functions.

    Car Struct
    Implement a struct called Car. 
    It should store the following properties:

    make
    model
    color
    numberOfDoors
    */

    struct Car {
        string make;
        string model;
        string color;
        uint256 numberOfDoors;
    }

    /*
    Add Car Garage
    Add a function called addCar 
    that adds a car to the user's collection in the garage. 
    It should:

    Use msg.sender to determine the owner
    Accept arguments for make, model, color, and number of doors, 
    and use those to create a new instance of Car
    Add that Car to the garage under the user's address
    */

    function addCar(
        string memory _make,
        string memory _model,
        string memory _color,
        uint256 _numberOfDoors
    ) public {
        Car memory newCar = Car(_make, _model, _color, _numberOfDoors);
        garage[msg.sender].push(newCar);
    }

    /*
    Get All Cars Belonging to a User
    Add a function called getMyCars. 
    It should return an array 
    with all of the cars owned by the calling user.
    */

    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    /*
    Get User Cars
    Add a function called getUserCars. 
    It should return an array 
    with all of the cars owned by the calling user.
    */

    function getUserCars(address user) public view returns (Car[] memory) {
        return garage[user];
    }

    /*
    Update Car
    Add a function called updateCar. 
    It should accept a uint for the index of the car to be updated, 
    and arguments for all of the Car types.

    If the sender doesn't have a car at that index, 
    it should revert with a custom error BadCarIndex and the index provided.

    Otherwise, it should update that entry to the new properties.
    */

    function updateCar(
        uint256 index,
        string memory _make,
        string memory _model,
        string memory _color,
        uint256 _numberOfDoors
    ) public {
        require(index < garage[msg.sender].length, "BadCarIndex");

        Car storage carToUpdate = garage[msg.sender][index];
        carToUpdate.make = _make;
        carToUpdate.model = _model;
        carToUpdate.color = _color;
        carToUpdate.numberOfDoors = _numberOfDoors;
    }

    /*
    Reset My Garage
    Add a public function called resetMyGarage. 
    It should delete the entry in garage for the sender.
    */

    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}
