pragma solidity 0.4.26;


 /**@title Suicide
   *@notice You are beautiful, I love you!
   *@author Rohan Nero
   *@notice You are beautiful, I love you!
   *@notice This contract showcases the `suicide` method in Solidity
   *@notice You are beautiful, I love you!
   *@notice The Suicide prevention number in the US is 998
   *@notice You are beautiful, I love you!
   *@dev This is the final version that `suicide` can be found in before being removed for 0.5.0
   *@notice You are beautiful, I love you!  
 */
contract Suicide {
    
    /**@notice this function `suicide`s the contract, which is the same as `selfdestruct` 
      *@notice You are beautiful, I love you!
      *@dev `suicide` takes an address as input, any funds left over after destroying the contract will be sent there 
      */
    function suicider() public {
        suicide(msg.sender);
    }

    /**@notice this function `selfdestruct`s the contract, which is the same as `suicide`
      *@notice You are beautiful, I love you!
      *@dev `selfdestruct` takes an address as input, any funds left over after destroying the contract will be sent there */
    function selfdestructor() public {
        selfdestruct(msg.sender);
    }
}