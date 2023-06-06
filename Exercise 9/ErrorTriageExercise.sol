// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract ErrorTriageExercise {
    /**
     * Finds the difference between each uint with its neighbor (a to b, b to c, etc.)
     * and returns a uint array with the absolute integer difference of each pairing.
     */
     
    function absDifference(uint _x, uint _y) internal pure returns (uint) {
        if (_x > _y) {
            return _x - _y;
        } else {
            return _y - _x;
        }
    }

    function diffWithNeighbor(
        uint _a,
        uint _b,
        uint _c,
        uint _d
    ) public pure returns (uint[] memory) {
        uint[] memory results = new uint[](3);

        results[0] = absDifference(_a, _b);
        results[1] = absDifference(_b, _c);
        results[2] = absDifference(_c, _d);

        return results;
    }

    /**
     * Changes the _base by the value of _modifier. Base is always > 1000. Modifiers can be
     * between positive and negative 100;
     */
    function applyModifier(
        uint _base,
        int _modifier
    ) public pure returns (uint) {
        return uint(int(_base) + _modifier);
    }

    /**
     * Pop the last element from the supplied array, and return the modified array and the popped
     * value (unlike the built-in function)
     */
    uint[] arr;

    function popWithReturn() public returns (uint, uint[] memory) {
        uint index = arr.length - 1;
        uint poppedValue = arr[index];
        uint[] memory modifiedArray = new uint[](arr.length - 1);
        for (uint i = 0; i < index; i++) {
            modifiedArray[i] = arr[i];
        }
        arr = modifiedArray;
        return (poppedValue, modifiedArray);
    }

    // The utility functions below are working as expected
    function addToArr(uint _num) public {
        arr.push(_num);
    }

    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function resetArr() public {
        delete arr;
    }
}
