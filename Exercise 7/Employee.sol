// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
Employee
Create an abstract contract called employee. It should have:

A public variable storing idNumber
A public variable storing managerId
A constructor that accepts arguments for and sets both of these variables
A virtual function called getAnnualCost that returns a uint
*/

abstract contract Employee {

    uint public idNumber;
    uint public managerId;
    
    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }
    
    function getAnnualCost() public virtual returns (uint);
}

/*
Salaried
A contract called Salaried. It should:

Inherit from Employee
Have a public variable for annualSalary
Implement an override function for getAnnualCost that returns annualSalary
An appropriate constructor that performs any setup, including setting annualSalary
*/

contract Salaried is Employee {
    uint public annualSalary;
    
    constructor(uint _idNumber, uint _managerId, uint _annualSalary) Employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }
    
    function getAnnualCost() public override returns (uint) {
        return annualSalary;
    }
}

/*
Hourly
Implement a contract called Hourly. It should:

Inherit from Employee
Have a public variable storing hourlyRate
Include any other necessary setup and implementation
*/

contract Hourly is Employee {
    uint public hourlyRate;
    
    constructor(uint _idNumber, uint _managerId, uint _hourlyRate) Employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }
    
    function getAnnualCost() public override returns (uint) {
        return hourlyRate * 2080;
    }
}

/*
Manager
Implement a contract called Manager. It should:

Have a public array storing employee Ids
Include a function called addReport that can add id numbers to that array
Include a function called resetReports that can reset that array to empty
*/

contract Manager {
    uint[] public employeeIds;
    
    function addReport(uint _employeeId) public {
        employeeIds.push(_employeeId);
    }
    
    function resetReports() public {
        delete employeeIds;
    }
}

/*
Salesperson
Implement a contract called Salesperson that inherits from Hourly.
*/

contract Salesperson is Hourly {
    constructor(uint _idNumber, uint _managerId, uint _hourlyRate) Hourly(_idNumber, _managerId, _hourlyRate) {
    }
}

/*
Engineering Manager
Implement a contract called EngineeringManager that inherits from Salaried and Manager.
*/

contract EngineeringManager is Salaried, Manager {
    constructor(uint _idNumber, uint _managerId, uint _annualSalary) Salaried(_idNumber, _managerId, _annualSalary) {
    }
}

/*
Inheritance Submission
*/

contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;
    
    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}