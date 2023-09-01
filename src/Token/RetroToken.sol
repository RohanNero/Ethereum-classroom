//SPDX-License-Identifier: GPL-3.0-or-later 

pragma solidity 0.4.16;

/**@title RetroToken
  *@author Rohan Nero
  *@notice This contract is based upon the original standardized "Currency" proposal from Vitalik
 */
contract RetroToken {

/**@notice send currency */
function sendCoin(uint _value, address _to) returns (bool _success){}

/**@notice send currency from another account */
function sendCoinFrom(address _from, uint _value, address _to) returns (bool _success) {}

/**@notice get your balance */
function coinBalance() constant returns (uint _r){} 

/**@notice get the balance of another account */
function coinBalanceOf(address _addr) constant returns (uint _r) {} 


/** 
  * The sendCoinFrom is used for a "direct debit" workflow, allowing contracts to charge fees in sub-currencies
  * The command should fail unless the from account has deliberately authorized the sender of the message via some mechanism
  * We propose these standardized APIs for approval:
*/

/**@notice allow addr to direct debit from your account */
function approve(address _addr) {} 

/**@notice returns 1 if proxy is allowed to direct debit from your account */
function isApproved(address _proxy) constant returns (bool _r) {} 

/**@notice returns 1 if proxy is allowed to direct debit from target */
function isApprovedFor(address _target, address _proxy) constant returns (bool _r){} 

/**@notice makes a one-time approval to send a maximum amount of currency equal to _maxval */
function approveOnce(address _addr, uint256 _maxValue) {}

// Events:

/**@notice triggered when money is sent */
event CoinSent(address indexed from, address indexed to, uint256 value); 

}