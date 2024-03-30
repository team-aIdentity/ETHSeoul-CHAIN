// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    mapping(string => uint256) public ticketIds;
    uint256 public nextId = 1;

    event TicketAdded(string indexed ticketName, uint256 indexed ticketId);

    // Function to add a new ticket name if it does not exist
    function addTicket(string memory ticketName) external {
        require(ticketIds[ticketName] == 0, "Ticket name already exists");
        ticketIds[ticketName] = nextId;
        emit TicketAdded(ticketName, nextId);
        nextId++;
    }

    // Function to check if a ticket name exists
    function titleExists(string memory ticketName) external view returns (bool) {
        return ticketIds[ticketName] != 0;
    }

    // Function to get the ID associated with a ticket name
    function getTitleId(string memory ticketName) external view returns (uint256) {
        return ticketIds[ticketName];
    }
}
