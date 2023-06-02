// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./SillyStringUtils.sol";

contract ImportsExercise {

    using SillyStringUtils for string;

    struct Haiku {
        string line1;
        string line2;
        string line3;
    }

    Haiku public haiku;

    /*
    Save Haiku
    saveHaiku should accept three strings and save them as the lines of haiku.
    */

    function saveHaiku(string memory _line1, string memory _line2, string memory _line3) public {
        haiku = Haiku(_line1, _line2, _line3);
    }

    /*
    Get Haiku
    getHaiku should return the haiku as a Haiku type.
    */

    function getHaiku() public view returns (Haiku memory) {
        return haiku;
    }

    /*
    Shruggie Haiku
    shruggieHaiku should use the library to add 🤷 to the end of line3. 
    It must not modify the original haiku.
    */

    function shruggieHaiku() public view returns (Haiku memory) {
        Haiku memory modifiedHaiku = haiku;
        modifiedHaiku.line3 = haiku.line3.shruggie();
        return modifiedHaiku;
    }
}
