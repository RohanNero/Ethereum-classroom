// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Signature} from "../src/Signature.sol";

contract SignatureTest is Test {
    Signature public signature;

    function setUp() public {
        signature = new Signature();
    }

}
