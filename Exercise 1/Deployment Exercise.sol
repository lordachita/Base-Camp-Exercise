// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract BasicMath {

    /*
    * Adder
    A function called adder. It must:
        * Accept two uint arguments, called _a and _b
        * Return a uint sum and a bool error
        * If _a + _b do not overflow, it should return the sum and an error of false
        * If _a + _b overflow, it should return 0 as the sum, and an error of `true
    */

    function adder(uint256 _a, uint256 _b) public pure returns (uint256, bool){
        
        uint256 MAX_INT = 2**256 - 1;

        if (MAX_INT - _a >= _b){
            return (_a + _b, false); 
        } 
        else {
            return (0, true); 
        }
    }

    /*
    * Subtractor
    A function called subtractor. It must:
        * Accept two uint arguments, called _a and _b
        * Return a uint difference and a bool error
        * If _a - _b does not underflow, it should return the difference and an error of false
        * If _a - _b underflows, it should return 0 as the difference, and an error of `true
    */

    function subtractor(uint256 _a, uint256 _b) public pure returns (uint256, bool){
        if (_a >= _b){
            return (_a - _b, false);
        }
        else{
            return (0, true);
        }
    }
}