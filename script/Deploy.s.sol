// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

import "forge-std/Script.sol";
import "../src/Counter.sol";
import "../src/ERC6551Account.sol";
import "../src/ERC6551Registry.sol";
import "../src/Profile.sol";
import "../src/Ticket.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); 
        vm.startBroadcast(deployerPrivateKey); 

        Counter counter = new Counter();
        ERC6551Account erc6551Account = new ERC6551Account();
        ERC6551Registry erc6551Registry = new ERC6551Registry();
        Profile profile = new Profile("http://localhost:5001");
        
        // Counter 컨트랙트의 주소를 Ticket 컨트랙트에 전달하여 생성
        Ticket ticket = new Ticket(address(counter), "http://localhost:5001");

        vm.stopBroadcast(); 
    }
}