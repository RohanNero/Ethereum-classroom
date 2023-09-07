//SPDX-License-Identifier: GPL-3.0-or-later 

pragma solidity 0.8.19;


error Token__InsufficientBalance();

contract Token {

/**@notice mapping of Token balances by address */
mapping(address owner => uint256) private _balances;

/**@notice mapping from spender address to the amount of Token they can spend on behalf of owner 
  *@dev owner --> spender --> allowance */
mapping(address owner => mapping(address spender => uint256)) private _allowances;

constructor() {
    _balances[msg.sender] = 777e18;
}



/**@notice This event is emitted when `transfer` and `transferFrom` are called
  *@dev MUST trigger when tokens are transferred, including zero value transfers  
  *@dev A token contract which creates new tokens SHOULD trigger a Transfer event with the _from address set to 0x0 when tokens are created */
event Transfer(address indexed _from, address indexed _to, uint256 _value);

/**@notice this event is triggered when `approve` is called
  *@dev MUST trigger on any successful call to approve(address _spender, uint256 _value) */ 
event Approval(address indexed _owner, address indexed _spender, uint256 _value);


/**@notice Returns the name of the token - e.g. "MyToken"
  *@dev OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present */
function name() public pure returns (string memory){
    return "Token";
}

/**@notice  Returns the symbol of the token. E.g. “HIX”
  *@dev OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present */
function symbol() public pure returns (string memory){
    return "TKN";
}

/**@notice Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation
  *@dev OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present */
function decimals() public pure returns (uint8){
    return 18;
}

/**@notice Returns the total token supply */
function totalSupply() public pure returns (uint256){
    return 777e18;
}

/**@notice Returns the account balance of another account with address _owner */
function balanceOf(address _owner) public view returns (uint256 balance){
    return _balances[_owner];
}

/**@notice Transfers _value amount of tokens to address _to, and MUST fire the Transfer event
  *@dev The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend
  *@dev Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event */
function transfer(address _to, uint256 _value) public returns (bool success){
    if(_balances[msg.sender] < _value) {
        revert Token__InsufficientBalance();
    }
}

/**@notice Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event
  *@dev The transferFrom method is used for a withdraw workflow, allowing contracts to transfer tokens on your behalf
  *@dev This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies
  *@dev The function SHOULD throw unless the _from account has deliberately authorized the sender of the message via some mechanism
  *@dev Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event */
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){}

/**@notice Allows _spender to withdraw from your account multiple times, up to the _value amount
  *@dev If this function is called again it overwrites the current allowance with _value
  *@dev To prevent attack vectors like the one described here and discussed here, 
clients SHOULD make sure to create user interfaces in such a way that they set the allowance first to 0,
 before setting it to another value for the same spender
  *@dev THOUGH The contract itself shouldn’t enforce it, to allow backwards compatibility with contracts deployed before */
function approve(address _spender, uint256 _value) public returns (bool success){}

/**@notice Returns the amount which _spender is still allowed to withdraw from _owner */
function allowance(address _owner, address _spender) public view returns (uint256 remaining){}

}