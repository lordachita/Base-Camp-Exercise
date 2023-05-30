// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract FavoriteRecords {

    /*
    State Variables
    The contract should have the following state variables. 
    It is up to you to decide if any supporting variables are useful.

    * A public mapping approvedRecords, 
    which returns true if an album name has been added as described below, 
    and false if it has not
    
    * A mapping called userFavorites 
    that indexes user addresses to a mapping of string record names 
    which returns true or false, 
    depending if the user has marked that album as a favorite
    */

    mapping(string => bool) public approvedRecords;
    mapping(address => mapping(string => bool)) public userFavorites;

    /*
    Loading Approved Albums
    Using the method of your choice, 
    load approvedRecords with the following:

    Thriller
    Back in Black
    The Bodyguard
    The Dark Side of the Moon
    Their Greatest Hits (1971-1975)
    Hotel California
    Come On Over
    Rumours
    Saturday Night Fever
    */

    constructor() {
        loadApprovedRecords();
    }

    function loadApprovedRecords() private {
        approvedRecords["Thriller"] = true;
        approvedRecords["Back in Black"] = true;
        approvedRecords["The Bodyguard"] = true;
        approvedRecords["The Dark Side of the Moon"] = true;
        approvedRecords["Their Greatest Hits (1971-1975)"] = true;
        approvedRecords["Hotel California"] = true;
        approvedRecords["Come On Over"] = true;
        approvedRecords["Rumours"] = true;
        approvedRecords["Saturday Night Fever"] = true;
    }

    /*
    Get Approved Records
    Add a function called getApprovedRecords. 
    This function should return a list of all of the names 
    currently indexed in approvedRecords.
    */

    function getApprovedRecords() public view returns (string[] memory) {
        string[] memory records = new string[](10);
        uint256 count = 0;

        for (uint256 i = 0; i < 10; i++) {
            string memory recordName = getApprovedRecordAtIndex(i);
            if (bytes(recordName).length > 0) {
                records[count] = recordName;
                count++;
            } 
            else {
                break;
            }
        }

        string[] memory result = new string[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = records[i];
        }

        return result;
    }

    function getApprovedRecordAtIndex(uint256 index) private view returns (string memory) {
        string[] memory records = new string[](10);
        records[0] = "Thriller";
        records[1] = "Back in Black";
        records[2] = "The Bodyguard";
        records[3] = "The Dark Side of the Moon";
        records[4] = "Their Greatest Hits (1971-1975)";
        records[5] = "Hotel California";
        records[6] = "Come On Over";
        records[7] = "Rumours";
        records[8] = "Saturday Night Fever";

        if (index < 9) {
            return records[index];
        } 
        else {
            return "";
        }
    }

    /*
    Add Record to Favorites

    Create a function called addRecord 
    that accepts an album name as a parameter. 

    If the album is on the approved list, 
    add it to the list under the address of the sender. 

    Otherwise, reject it with a custom error of NotApproved 
    with the submitted name as an argument.
    */
    error NotApproved(string albumName);

    function addRecord(string memory albumName) public {
        if (approvedRecords[albumName]) {
            userFavorites[msg.sender][albumName] = true;
        } 
        else {
            revert NotApproved(albumName);
        }
    }

    /*
    Users' Lists
    Write a function called getUserFavorites 
    that retrieves the list of favorites for any address.
    */

    function getUserFavorites(address user) public view returns (string[] memory) {
        uint256 count = getFavoriteRecordsCount(user);
        string[] memory favorites = new string[](count);

        for (uint256 i = 0; i < count; i++) {
            favorites[i] = getFavoriteRecordAtIndex(user, i);
        }

        return favorites;
    }

    function getFavoriteRecordAtIndex(address user, uint256 index) private view returns (string memory) {
        string[] memory favoriteRecords = getFavoriteRecords(user);

        if (index < favoriteRecords.length) {
            return favoriteRecords[index];
        } 
        else {
            return "";
        }
    }

    function getFavoriteRecordsCount(address user) private view returns (uint256) {
        string[] memory favoriteRecords = getFavoriteRecords(user);
        return favoriteRecords.length;
    }

    function getFavoriteRecords(address user) private view returns (string[] memory) {
        uint256 count = 0;
        string[] memory favorites = new string[](10);

        for (uint256 i = 0; i < 10; i++) {
            string memory recordName = getApprovedRecordAtIndex(i);
            if (userFavorites[user][recordName]) {
                if (count == favorites.length) {
                    string[] memory newFavorites = new string[](count + 10);
                    for (uint256 j = 0; j < count; j++) {
                        newFavorites[j] = favorites[j];
                    }
                    favorites = newFavorites;
                }

                favorites[count] = recordName;
                count++;
            }
        }

        string[] memory result = new string[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = favorites[i];
        }

        return result;
    }



    /*
    Reset My Favorites
    Add a function called resetUserFavorites that resets userFavorites for the sender.
    */
    function resetUserFavorites() public {
        address sender = msg.sender;
        mapping(string => bool) storage favorites = userFavorites[sender];

        // Reset each favorite record individually
        for (uint256 i = 0; i < getFavoriteRecordsCount(sender); i++) {
            string memory recordName = getFavoriteRecordAtIndex(sender, i);
            favorites[recordName] = false;
        }
    }
}