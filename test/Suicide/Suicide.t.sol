//SPDX-License-Identifier: GPL-3.0-or-later 
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
//import {Suicide} from "../../src/Suicide/Suicide.sol";

contract SuicideTest is Test {

    address public suicider;

    /**@notice deploy contract in this way because foundry is scared of ancient solidity */
    function setUp() public {
       suicider = deployCode("Suicide.sol");
    }

    /**@notice tests the contract suicide by viewing balance before and after */
    function testSuicide() public {
        vm.deal(suicider, 777);
        uint pre = suicider.balance;
        console2.log(pre);
        (bool success, ) = suicider.call(abi.encodeWithSignature("suicider()"));
        console2.log(success);
        uint post = suicider.balance;
        console2.log(post);
        assertEq(pre - 777, post);
    }

     /**@notice tests the contract selfdestruct by viewing balance before and after */
    function testSelfdestruct() public {
        vm.deal(suicider, 777);
        uint pre = suicider.balance;
        console2.log(pre);
        (bool success, ) = suicider.call(abi.encodeWithSignature("selfdestructor()"));
        console2.log(success);
        uint post = suicider.balance;
        console2.log(post);
        assertEq(pre - 777, post);
    }

}
