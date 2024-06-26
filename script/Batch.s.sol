// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "forge-std/Script.sol";
import "forge-std/StdJson.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

interface NFT_Minter {
    function safeMint(address account, uint256 id) external;
    function safeBurn(uint256 id) external;
}

contract BatchScript is Script {
using stdJson for string;
    function setUp() public {}

    function run() public {
        //uint256 idCounter = 0 + 1;
        address nft_contract = 0x3530bf96982Fa5A9E0d8Bad84d3587E51A33d332;
        uint256 users_length = 13445;
        uint256 json_length = 200;
        uint256 json_counter = 1; //TODO
        uint256 lastCount = 10578;  //TODO

vm.startBroadcast();

        for (uint index = lastCount; index < users_length; index++) {
            string memory root = vm.projectRoot();
            //if (index % 100 == 0) { change name of the json file to be read
            string memory path;
            
            path = string.concat(root, "/drops/checksummed_tokenholders_", Strings.toString(json_counter), ".json");
            //console.log("Path: ", path);
            string memory json = vm.readFile(path);
            //console.log("JSON: ", json);
            //. + index + [0]//
            string memory indexString = string.concat(".",Strings.toString(index));
            //console.log("Index: ", indexString);
            bytes memory transactionDetails = json.parseRaw(indexString);
            address rawConstants = abi.decode(transactionDetails, (address));
            
            console.log("mint ", rawConstants, index);
/*
            if (rawConstants == 0x73fBD93bFDa83B111DdC092aa3a4ca77fD30d380) {
                console.log("Address is Token, skipping");
                continue;
            }
*/       

            if(!_isContract(rawConstants)) {
                NFT_Minter(nft_contract).safeMint(rawConstants, index);
                console.log("Minted NFT for address: ", rawConstants);
                console.log("NFT ID: ", index);
                console.log("JSON File: ", path);
                console.log("JSON Counter: ", json_counter);
            }
            else{
                console.log("Address is Token, skipping");
                continue;
            }
        //vm.stopBroadcast();

            if (index % 100 == 0) {
                console.log("Index: ", index);
                json_counter++;
            }

            if(json_length == json_counter) {
                break;
            }
        }
    vm.stopBroadcast();

    }

    function _isContract(address _addr) private view returns (bool) {
        uint256 codeLength;

        // Assembly required for versions < 0.8.0 to check extcodesize.
        assembly {
            codeLength := extcodesize(_addr)
        }

        return codeLength > 0;
    }
}
