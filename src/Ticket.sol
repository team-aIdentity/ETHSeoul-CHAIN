// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Counter.sol";

contract Ticket is ERC1155 {
    Counter public counterContract;
    string public baseURI;

    // Event to track ticket issuance
    event TicketIssued(string indexed ticketName, uint256 indexed ticketId, address indexed user, uint256 amount);

    constructor(address _counterContract, string memory _baseURI) ERC1155("") {
        counterContract = Counter(_counterContract);
        baseURI = _baseURI;
    }

    // Function to issue tickets to a user for a specific ticket
    function issueTicket(string memory ticketName, uint256 ticketId, uint256 amount) external {
        if (!counterContract.titleExists(ticketName)) {
            counterContract.addTicket(ticketName);
        }
        uint256 tokenId = counterContract.getTitleId(ticketName);
        _mint(msg.sender, tokenId, amount, "");
        emit TicketIssued(ticketName, tokenId, msg.sender, amount);
    }

    // Function to get the balance of tickets for a user for a specific ticket
    function balanceOfTicket(string memory ticketName) external view returns (uint256) {
        uint256 tokenId = counterContract.getTitleId(ticketName);
        return balanceOf(msg.sender, tokenId);
    }

    // Function to verify if a user holds a certain number of tickets for a specific ticket
    function hasTickets(string memory ticketName, uint256 amount) external view returns (bool) {
        uint256 tokenId = counterContract.getTitleId(ticketName);
        return balanceOf(msg.sender, tokenId) >= amount;
    }

    // Function to set the base URI
    function setBaseURI(string memory _baseURI) external {
        baseURI = _baseURI;
    }

    // Function to override the base URI for a token ID
    function uri(uint256 tokenId) public view override returns (string memory) {
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, Strings.toString(tokenId))) : "";
    }
}
