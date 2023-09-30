# Quick notes

### Suicide

Issues testing this contract because of the old solidity version, `getCode()` was a proposed solution to this issue but not sure it will work for my situation.
https://github.com/foundry-rs/foundry/issues/326
https://github.com/foundry-rs/foundry/pull/440
https://book.getfoundry.sh/cheatcodes/get-code
https://book.getfoundry.sh/reference/forge-std/deployCode

When in doubt, I'll write a deploy script for it, then the test will just call the deploy script and make function calls that way.

## Subject Statuses

1. `Suicide.sol` showcases EIP 6 **FIN**
1. `Token.sol` showcases ERC-20 **FIN**
1. `Ownable.sol` showcases EIP 173 **WIP**
1. `Signature.sol` showases EIP 191 and EIP 712
1. `Encoding.sol` showcases abi encoding
1. `Decoding.sol` showcases abi decoding
1. `FatDragon.sol` showcase EIP 170 and 607
1. `NonFungibleToken.sol` showcases ERC-721
1. `Proxy.sol` showcases EIP 1167
1. `ProxyStorage.sol` showcases EIP 1967
1. `RoyaltyStandard.sol` showcases EIP 2981
1. `NewContractPrefix` showcases EIP 3541
1. `Flashloan.sol` showcases flashloans EIP 3156
1. `Vault.sol` showcases ERC-4626
1. `SelfDestruct` showcases EIP 6049
1. `NFTMarket.sol` showcases ERC-6105 **WIP**
1. `Merkle.sol` showcases a Merkle proof
