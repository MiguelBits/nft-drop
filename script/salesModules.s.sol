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

interface NFT {
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
}

contract saleScript is Script {
    using stdJson for string;

            bytes32 constant META_ADMIN = keccak256("metaadmin");
        bytes32 constant OWNER = keccak256("owner");

    struct UserQt {
        address user;
        uint256 qt;
    }

    NFT_Minter MINTER = NFT_Minter(0x913b55d1ad953B9D7fe2f78Ff844ADDd74CEeF3f);
    NFT NFT_CONTRACT = NFT(0x66705a07fa726e19BB132c8d8BEcBe6713670160);
    uint256 season = 1;
    uint256 density = 1; //TODO

    function setUp() public {}

    function run() public {

        _mint("/sales/npcguild.json"); //TODO

    }

    function _mint(string memory _path) public {

        uint256 completeJSON = 33; //TODO

        uint256 users_length = completeJSON; //TODO

        uint256 json_lastCount = 6;  // can stay the same because we check quantity of NFTs minted

        //console.log("json_lastCount: ", completeJSON - json_lastCount);
/*
        string memory root = vm.projectRoot();
        string memory path;
        
        path = string.concat(root, _path);
        string memory json = vm.readFile(path);
*/
        for (uint index = json_lastCount; index <= users_length; index++) {
 /*
            console.log("index: ", index);

            string memory indexString = string.concat(".",Strings.toString(index));
            bytes memory transactionDetails = json.parseRaw(indexString);
            UserQt memory rawConstants = abi.decode(transactionDetails, (UserQt));

            console.log("user: ", rawConstants.user);
            console.log("qt: ",  rawConstants.qt);
*/
            vm.broadcast();
            //MINTER.batchMintInventory(season, density, rawConstants.user, rawConstants.qt);
            NFT_CONTRACT.safeTransferFrom(
                0x027a5cE58fc466D0e3A9D1990404354029398541, 
                0xE114971Feb40f2645eAD061d4628906f7b912f61, 
                index);
        }

    }

}