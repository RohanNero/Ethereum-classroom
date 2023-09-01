//SPDX-License-Identifier: GPL-3.0-or-later 

pragma solidity 0.8.19;

contract Token {

//  name
// Returns the name of the token - e.g. "MyToken".
// OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
function name() public view returns (string memory){}

//  symbol
// Returns the symbol of the token. E.g. “HIX”.
// OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
function symbol() public view returns (string memory){}

//  decimals
// Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation.
// OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
function decimals() public view returns (uint8){}

//  totalSupply
// Returns the total token supply.
function totalSupply() public view returns (uint256){}

//  balanceOf
// Returns the account balance of another account with address _owner.
function balanceOf(address _owner) public view returns (uint256 balance){}

//  transfer
// Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend.
// Note Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.
function transfer(address _to, uint256 _value) public returns (bool success){}

//  transferFrom
// Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.
// The transferFrom method is used for a withdraw workflow, allowing contracts to transfer tokens on your behalf. This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies. The function SHOULD throw unless the _from account has deliberately authorized the sender of the message via some mechanism.
// Note Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){}

//  approve
// Allows _spender to withdraw from your account multiple times, up to the _value amount. If this function is called again it overwrites the current allowance with _value.
// NOTE: To prevent attack vectors like the one described here and discussed here, clients SHOULD make sure to create user interfaces in such a way that they set the allowance first to 0 before setting it to another value for the same spender. THOUGH The contract itself shouldn’t enforce it, to allow backwards compatibility with contracts deployed before
function approve(address _spender, uint256 _value) public returns (bool success){}

//  allowance
// Returns the amount which _spender is still allowed to withdraw from _owner.
function allowance(address _owner, address _spender) public view returns (uint256 remaining){}

}