// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract ArraysExercise {

    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];
    uint[] public timestamps;
    address[] public senders;

    /*
    Return a Complete Array
    The compiler automatically adds a getter for individual elements in the array, 
    but it does not automatically provide functionality to retrieve the entire array.
    Write a function called getNumbers that returns the entire numbers array.
    */

    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    /*
    Reset Numbers
    Write a public function called resetNumbers 
    that resets the numbers array to its initial value, holding the numbers from 1-10.
    */
    function resetNumbers() public {
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }

    /*
    Append to an Existing Array
    Write a function called appendToNumbers 
    that takes a uint[] calldata array called _toAppend, 
    and adds that array to the storage array called numbers, 
    already present in the starter.
    */
    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    /*
    Timestamp Saving
    At the contract level, add an address array called senders 
    and a uint array called timestamps.
    Write a function called saveTimestamp 
    that takes a uint called _unixTimestamp as an argument. 
    When called, it should add the address of the caller 
    to the end of senders and the _unixTimeStamp to timestamps.
    */
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    /*
    Timestamp Filtering
    Write a function called afterY2K that takes no arguments. 
    When called, it should return two arrays.

    The first should return all timestamps 
    that are more recent than January 1, 2000, 12:00am. 
    To save you a click, the Unix timestamp for this date and time is 946702800.

    The second should return a list of senders addresses corresponding to those timestamps.
    */
    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint[] memory recentTimestamps = new uint[](timestamps.length);
        address[] memory recentSenders = new address[](senders.length);
        uint count = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                recentTimestamps[count] = timestamps[i];
                recentSenders[count] = senders[i];
                count++;
            }
        }

        // Create new arrays with correct size
        uint[] memory filteredTimestamps = new uint[](count);
        address[] memory filteredSenders = new address[](count);
        // Copy filtered data to new arrays
        for (uint i = 0; i < count; i++) {
            filteredTimestamps[i] = recentTimestamps[i];
            filteredSenders[i] = recentSenders[i];
        }

    return (filteredTimestamps, filteredSenders);
}

    /*
    Resets
    Add public functions called resetSenders and resetTimestamps 
    that reset those storage variables.
    */
    
    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        delete timestamps;
    }
}