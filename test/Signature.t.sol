//SPDX-License-Identifier: GPL-3.0-or-later 
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Signature} from "../src/Signature/Signature.sol";

contract SignatureTest is Test {
    Signature public signature;

    function setUp() public {
        signature = new Signature();
    }

}
