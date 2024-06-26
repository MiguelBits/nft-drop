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

contract FixScript is Script {
    using stdJson for string;

    struct UserQt {
        address user;
        uint256 qt;
    }

    function setUp() public {}

    function run() public {


        //uint256 idCounter = 0 + 1;
        address nft_contract = 0xcB841a28f16f99e3A561dbEbA7e09abc9120a45f;
        //_burn(nft_contract);
        _mint(nft_contract, "/drops/d1_holders_output_BSC.json");

    }

    function _mint(address nft_contract, string memory _path) public {

        uint256 completeJSON = 1195; //TODO

        uint256 users_length = completeJSON; //TODO

        uint256 json_lastCount = 1;  // can stay the same because we check quantity of NFTs minted

        uint256 last_onChain_index_minted = 11777; //TODO

        console.log("json_lastCount: ", completeJSON - json_lastCount);

        string memory root = vm.projectRoot();
        string memory path;
        
        path = string.concat(root, _path);
        string memory json = vm.readFile(path);
        NFT_Minter minter = NFT_Minter(nft_contract);

        for (uint index = json_lastCount; index <= users_length; index++) {
 
            console.log("index: ", index);

            string memory indexString = string.concat(".",Strings.toString(index));
            bytes memory transactionDetails = json.parseRaw(indexString);
            UserQt memory rawConstants = abi.decode(transactionDetails, (UserQt));

            uint256 userBalance = minter.balanceOf(rawConstants.user);

            //if(_isContract(rawConstants.user)) continue;
            
            if(userBalance >= rawConstants.qt){
                console.log("User already has the required amount of NFTs");
                continue;
            }

            uint256 qtLeft = rawConstants.qt - userBalance;

            console.log("user: ", rawConstants.user);
            console.log("userBalance: ", userBalance);
            console.log("qtLeft: ", qtLeft);

            for(uint i = 0; i < qtLeft; i++){
                vm.broadcast();
                minter.safeMint(rawConstants.user, last_onChain_index_minted + 1);
                last_onChain_index_minted += 1;
            }
        }
    }
    function _isContract(address _addr) private view returns (bool) {
        uint256 codeLength;

        // Assembly required for versions < 0.8.0 to check extcodesize.
        assembly {
            codeLength := extcodesize(_addr)
        }

        return codeLength > 0;
    }
/*
    function _burn(address nft_contract) public {
        uint16[] memory burn_array = new uint16[](210);
        burn_array[0] = 1;
        burn_array[1] = 21;
        burn_array[2] = 41;
        burn_array[3] = 53;
        burn_array[4] = 64;
        burn_array[5] = 74;
        burn_array[6] = 84;
        burn_array[7] = 94;
        burn_array[8] = 104;
        burn_array[9] = 114;
        burn_array[10] = 124;
        burn_array[11] = 134;
        burn_array[12] = 144;
        burn_array[13] = 154;
        burn_array[14] = 164;
        burn_array[15] = 174;
        burn_array[16] = 184;
        burn_array[17] = 194;
        burn_array[18] = 204;
        burn_array[19] = 214;
        burn_array[20] = 224;
        burn_array[21] = 234;
        burn_array[22] = 244;
        burn_array[23] = 254;
        burn_array[24] = 264;
        burn_array[25] = 274;
        burn_array[26] = 284;
        burn_array[27] = 294;
        burn_array[28] = 303;
        burn_array[29] = 311;
        burn_array[30] = 318;
        burn_array[31] = 324;
        burn_array[32] = 329;
        burn_array[33] = 334;
        burn_array[34] = 339;
        burn_array[35] = 344;
        burn_array[36] = 348;
        burn_array[37] = 352;
        burn_array[38] = 356;
        burn_array[39] = 360;
        burn_array[40] = 364;
        burn_array[41] = 367;
        burn_array[42] = 370;
        burn_array[43] = 373;
        burn_array[44] = 376;
        burn_array[45] = 379;
        burn_array[46] = 382;
        burn_array[47] = 385;
        burn_array[48] = 387;
        burn_array[49] = 389;
        burn_array[50] = 391;
        burn_array[51] = 393;
        burn_array[52] = 395;
        burn_array[53] = 397;
        burn_array[54] = 399;
        burn_array[55] = 401;
        burn_array[56] = 403;
        burn_array[57] = 405;
        burn_array[58] = 407;
        burn_array[59] = 409;
        burn_array[60] = 411;
        burn_array[61] = 413;
        burn_array[62] = 415;
        burn_array[63] = 417;
        burn_array[64] = 419;
        burn_array[65] = 421;
        burn_array[66] = 423;
        burn_array[67] = 425;
        burn_array[68] = 427;
        burn_array[69] = 428;
        burn_array[70] = 429;
        burn_array[71] = 430;
        burn_array[72] = 431;
        burn_array[73] = 432;
        burn_array[74] = 433;
        burn_array[75] = 434;
        burn_array[76] = 435;
        burn_array[77] = 436;
        burn_array[78] = 437;
        burn_array[79] = 438;
        burn_array[80] = 439;
        burn_array[81] = 440;
        burn_array[82] = 441;
        burn_array[83] = 442;
        burn_array[84] = 443;
        burn_array[85] = 444;
        burn_array[86] = 445;
        burn_array[87] = 446;
        burn_array[88] = 447;
        burn_array[89] = 448;
        burn_array[90] = 449;
        burn_array[91] = 450;
        burn_array[92] = 451;
        burn_array[93] = 452;
        burn_array[94] = 453;
        burn_array[95] = 454;
        burn_array[96] = 455;
        burn_array[97] = 456;
        burn_array[98] = 457;
        burn_array[99] = 458;
        burn_array[100] = 459;
        burn_array[101] = 460;
        burn_array[102] = 461;
        burn_array[103] = 462;
        burn_array[104] = 463;
        burn_array[105] = 464;
        burn_array[106] = 465;
        burn_array[107] = 466;
        burn_array[108] = 467;
        burn_array[109] = 468;
        burn_array[110] = 469;
        burn_array[111] = 470;
        burn_array[112] = 471;
        burn_array[113] = 472;
        burn_array[114] = 473;
        burn_array[115] = 474;
        burn_array[116] = 475;
        burn_array[117] = 476;
        burn_array[118] = 477;
        burn_array[119] = 478;
        burn_array[120] = 479;
        burn_array[121] = 480;
        burn_array[122] = 481;
        burn_array[123] = 482;
        burn_array[124] = 483;
        burn_array[125] = 484;
        burn_array[126] = 485;
        burn_array[127] = 486;
        burn_array[128] = 487;
        burn_array[129] = 488;
        burn_array[130] = 489;
        burn_array[131] = 490;
        burn_array[132] = 491;
        burn_array[133] = 492;
        burn_array[134] = 493;
        burn_array[135] = 494;
        burn_array[136] = 495;
        burn_array[137] = 496;
        burn_array[138] = 497;
        burn_array[139] = 498;
        burn_array[140] = 499;
        burn_array[141] = 500;
        burn_array[142] = 501;
        burn_array[143] = 502;
        burn_array[144] = 503;
        burn_array[145] = 504;
        burn_array[146] = 505;
        burn_array[147] = 506;
        burn_array[148] = 507;
        burn_array[149] = 508;
        burn_array[150] = 509;
        burn_array[151] = 510;
        burn_array[152] = 511;
        burn_array[153] = 512;
        burn_array[154] = 513;
        burn_array[155] = 514;
        burn_array[156] = 515;
        burn_array[157] = 516;
        burn_array[158] = 517;
        burn_array[159] = 518;
        burn_array[160] = 519;
        burn_array[161] = 520;
        burn_array[162] = 521;
        burn_array[163] = 522;
        burn_array[164] = 523;
        burn_array[165] = 524;
        burn_array[166] = 525;
        burn_array[167] = 526;
        burn_array[168] = 527;
        burn_array[169] = 528;
        burn_array[170] = 529;
        burn_array[171] = 530;
        burn_array[172] = 531;
        burn_array[173] = 532;
        burn_array[174] = 533;
        burn_array[175] = 534;
        burn_array[176] = 535;
        burn_array[177] = 536;
        burn_array[178] = 537;
        burn_array[179] = 538;
        burn_array[180] = 539;
        burn_array[181] = 540;
        burn_array[182] = 541;
        burn_array[183] = 542;
        burn_array[184] = 543;
        burn_array[185] = 544;
        burn_array[186] = 545;
        burn_array[187] = 546;
        burn_array[188] = 547;
        burn_array[189] = 548;
        burn_array[190] = 549;
        burn_array[191] = 550;
        burn_array[192] = 551;
        burn_array[193] = 552;
        burn_array[194] = 553;
        burn_array[195] = 554;
        burn_array[196] = 555;
        burn_array[197] = 556;
        burn_array[198] = 557;
        burn_array[199] = 558;
        burn_array[200] = 559;
        burn_array[201] = 560;
        burn_array[202] = 561;
        burn_array[203] = 562;
        burn_array[204] = 563;
        burn_array[205] = 564;
        burn_array[206] = 565;
        burn_array[207] = 566;
        burn_array[208] = 567;
        burn_array[209] = 568;

        uint256 users_length = 194; //TODO
        vm.startBroadcast();
        for (uint index = 0; index < users_length; index++) {            

            console.log("burn ", burn_array[index]);
            /// BURN //////////////////////////////////////////
            NFT_Minter(nft_contract).safeBurn(burn_array[index]);
            if(burn_array[index] == users_length){
                break;
            }
    
        }
        vm.stopBroadcast();

    }
*/

}