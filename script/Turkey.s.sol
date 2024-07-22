// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "forge-std/Script.sol";
import "forge-std/StdJson.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

interface NFT_Minter {
    function batchMintInventory(uint256 season, uint256 density, address user, uint256 quantity) external;
    function balanceOf(address account) external view returns (uint256);
}

contract tURKEYScript is Script {
    using stdJson for string;

    NFT_Minter MINTER = NFT_Minter(0x98d722E1963C823d06F43d4294320B47Aa761041);
    uint256 season = 1;
    uint256 density = 1; //TODO

    function setUp() public {}

    function run() public {

        _mint("/sales/BaseDensityDrop.json"); //TODO

    }

    function _mint(string memory _path) public {

        uint256 completeJSON = 21; //TODO

        uint256 users_length = completeJSON; //TODO

        uint256 json_lastCount = 10;  // can stay the same because we check quantity of NFTs minted

        string memory root = vm.projectRoot();
        string memory path;
        
        path = string.concat(root, _path);
        string memory json = vm.readFile(path);

        for (uint index = json_lastCount; index <= users_length; index++) {
 
            console.log("index: ", index);

            string memory indexString = string.concat(".",Strings.toString(index));
            bytes memory transactionDetails = json.parseRaw(indexString);
            address rawConstants = abi.decode(transactionDetails, (address));

            console.log("user: ", rawConstants);

            vm.broadcast();
            MINTER.batchMintInventory(season, density, rawConstants, 1);
            

        }

    }

}