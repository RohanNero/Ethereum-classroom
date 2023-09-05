//SPDX-License-Identifier: GPL-3.0-or-later 
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
//import {Suicide} from "../../src/Suicide/Suicide.sol";

contract SuicideTest is Test {
    Suicide public suicider;

    function setUp() public {
        suicider = new Suicide();
    }

    function testSuicide() public {

    }

}
