// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "forge-std/Script.sol";
import "forge-std/StdJson.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

interface NFT_Minter {
    function safeMint(address account, uint256 id) external;
    function safeBurn(uint256 id) external;
    function balanceOf(address account) external view returns (uint256);
}

contract VaultScript is Script {
using stdJson for string;
    function setUp() public {}

    function run() public {


        //uint256 idCounter = 0 + 1;
        address nft_contract = 0xcEF37C9Be40439C7354db9d76DE663858271279e; //TODO
        //_burn(nft_contract);
        _mint(nft_contract, "/vaulters/bsc_sdao.json"); //TODO

    }

    function _mint(address nft_contract, string memory _path) public {

        uint256 completeJSON = 875; //TODO

        uint256 users_length = completeJSON; //TODO

        uint256 json_lastCount = 208;  //TODO

        //console.log("json_lastCount: ", completeJSON - json_lastCount);

        uint256 last_onChain_index_minted = 3015; //TODO

        string memory root = vm.projectRoot();
        string memory path;
        
        path = string.concat(root, _path);
        string memory json = vm.readFile(path);

        for (uint index = json_lastCount; index <= users_length; index++) {
 
            console.log("index: ", index);

            string memory indexString = string.concat(".",Strings.toString(index));
            bytes memory transactionDetails = json.parseRaw(indexString);

            address rawConstants = abi.decode(transactionDetails, (address));

            vm.broadcast();
            NFT_Minter(nft_contract).safeMint(rawConstants, index + last_onChain_index_minted);

            console.log("Minted NFT for address: ", rawConstants);
            console.log("NFT ID: ", index + last_onChain_index_minted);
        }
    }
}