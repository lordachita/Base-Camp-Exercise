// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
Imported Contracts
Review the Ownable contract from OpenZeppelin. You'll need to use it to solve this exercise.

You may wish to use another familiar contract to help with this challenge.
*/
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    Contact[] private contacts;
    uint private nextId = 1;

    event ContactAdded(uint indexed id, string firstName, string lastName);
    event ContactDeleted(uint indexed id);

    constructor(address initialOwner) Ownable(initialOwner) {}

    function addContact(string memory firstName, string memory lastName, uint[] memory phoneNumbers) public onlyOwner {
        Contact memory newContact = Contact(nextId, firstName, lastName, phoneNumbers);
        contacts.push(newContact);
        emit ContactAdded(nextId, firstName, lastName);
        nextId++;
    }

    function deleteContact(uint id) public onlyOwner {
        uint index = findContactIndex(id);
        require(index != type(uint).max, "ContactNotFound");
        delete contacts[index];
        emit ContactDeleted(id);
    }

    function getContact(uint id) public view returns (Contact memory) {
        uint index = findContactIndex(id);
        require(index != type(uint).max, "ContactNotFound");
        return contacts[index];
    }

    function getAllContacts() public view returns (Contact[] memory) {
        uint validContactCount = 0;
        for (uint i = 0; i < contacts.length; i++) {
            if (contacts[i].id != 0) {
                validContactCount++;
            }
        }

        Contact[] memory allContacts = new Contact[](validContactCount);
        uint currentIndex = 0;

        for (uint i = 0; i < contacts.length; i++) {
            if (contacts[i].id != 0) {
                allContacts[currentIndex] = contacts[i];
                currentIndex++;
            }
        }

        return allContacts;
    }

    function findContactIndex(uint id) private view returns (uint) {
        for (uint i = 0; i < contacts.length; i++) {
            if (contacts[i].id == id) {
                return i;
            }
        }
        return type(uint).max;
    }
}

contract AddressBookFactory {
    address[] private deployedAddressBooks;

    event AddressBookDeployed(address indexed addressBookAddress, address indexed owner);

    function deploy() public returns (address) {
        AddressBook newAddressBook = new AddressBook(msg.sender);
        deployedAddressBooks.push(address(newAddressBook));
        emit AddressBookDeployed(address(newAddressBook), msg.sender);
        return address(newAddressBook);
    }

    function getDeployedAddressBooks() public view returns (address[] memory) {
        return deployedAddressBooks;
    }
}




