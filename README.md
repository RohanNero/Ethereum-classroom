# Ethereum Classroom

This repo consists of a handful of directories containing smart contracts that each showcase a different Solidity/Ethereum concept.
One concept may contain multiple smart contracts, and some special smart contracts prefixed `Retro` are based upon the original proposal/ideas for the standards and may not reflect the final EIP.

With that said, dive in and explore the world of **Ethereum**!

![image](https://github.com/RohanNero/foundry-classroom/assets/100052099/e352be70-bcee-4296-9fb9-ecb382acb6b5)

## Content overview

In order corresponding to the src directory:

1. `Suicide.sol` showcases EIP 6
1. `Token.sol` showcases ERC-20
1. `Ownable.sol` showcases EIP 173
1. `Signature.sol` showases EIP 191 and EIP 712
1. `Encoding.sol` showcases abi encoding
1. `Decoding.sol` showcases abi decoding
1. `FatDragon.sol` showcase EIP 170 and 607
1. `NonFungibleToken.sol` showcases ERC-721
1. `Proxy.sol` showcases EIP 1167
1. `ProxyStorage.sol` showcases EIP 1967
1. `NewContractPrefix` showcases EIP 3541
1. `Flashloan.sol` showcases flashloans EIP 3156
1. `Vault.sol` showcases ERC-4626
1. `SelfDestruct` showcases EIP 6049
1. `NFTMarket.sol` showcases ERC-6105
1. `Merkle.sol` showcases a Merkle proof

[List of EIPs](https://eips.ethereum.org/all)

## Suicide.sol

This contract showcases EIP 6 by allowing you to test using it for yourself!

The `Suicide` opcode was removed early on in Ethereum's history for obvious reasons, you can test the removal in action for yourself by changing the `pragma solidity 0.4.26;` line to `pragma solidity 0.5.0;`, and then running `forge build`.

#### Suicide Resources

- [Official EIP 6](https://eips.ethereum.org/EIPS/eip-6)

## Token

This folder showcases ERC20 by allowing you test using some for yourself!

### Token.sol

The main contract in the directory is `Token.sol`, it follows the EIP-20 guidelines perfectly!

### RetroToken.sol

This `Retro` contract is based upon Vitalik's first proposal for standardized currencies!

#### Token Resources

- [Official EIP](https://eips.ethereum.org/EIPS/eip-20)
- [Original Proposal](https://github.com/ethereum/wiki/wiki/Standardized_Contract_APIs/499c882f3ec123537fc2fccd57eaa29e6032fe4a)
- []()
- []()

## Ownable.sol

This contract showcases EIP 173 by allowing you to test using it for yourself!

#### Ownable Resources

- [Official EIP 173](https://eips.ethereum.org/EIPS/eip-173)
- [OpenZeppelin access control](https://docs.openzeppelin.com/contracts/4.x/access-control)
- [Open Zeppelin vs 173](https://forum.openzeppelin.com/t/ownable-to-be-eip-173/31590)
- []()

## Signature.sol

This contract showcases EIPs 191 and 712 by allowing you test using ECDSA recover for yourself!

#### Signature Resources

- [Foundry book guide](https://book.getfoundry.sh/tutorials/testing-eip712?highlight=vm.addr#bundled-example)
- [SMP video tutorial](https://www.youtube.com/watch?v=cs5IeYqviSQ)
- [SMP written tutorial](https://solidity-by-example.org/signature/)
- [Medium article](https://medium.com/metamask/eip712-is-coming-what-to-expect-and-how-to-use-it-bb92fd1a7a26)

## Encoding.sol

This contract showcases abi encoding by allowing you test using it for yourself!

#### Encoding Resources

- []()
- []()
- []()
- []()

## Decoding.sol

This contract showcases abi decoding by allowing you test using it for yourself!

#### Decoding Resources

- []()
- []()
- []()
- []()

## FatDragon.sol

This contract showcases EIP 170 and 607 by allowing you test it out for yourself!

#### FatDragon Resources

- []()
- []()
- []()
- []()

## NonFungibleToken.sol

This contract showcases ERC721 by allowing you test using one for yourself!

#### NonFungibleToken Resources

- [Official EIP](https://eips.ethereum.org/EIPS/eip-721)
- []()
- []()
- []()

## Proxy.sol

This contract showcases EIP by allowing you test using for yourself!

#### Proxy Resources

- []()
- []()
- []()
- []()

## ProxyStorage.sol

This contract showcases EIP by allowing you test using for yourself!

#### ProxyStorage Resources

- []()
- []()
- []()
- []()

## NewContractPrefix.sol

This contract showcases EIP 3541 by allowing you test using it for yourself!

#### NewContractPrefix Resources

- [Official EIP](https://eips.ethereum.org/EIPS/eip-3541)
- []()
- []()
- []()

## Flashloan.sol

This contract showcases EIP 3156 by allowing you test using flashloans for yourself!

### Flashloan Resources

- []()
- []()
- []()
- []()

## Vault.sol

This contract showcases ERC4626 by allowing you test using one for yourself!

#### Vault Resources

- [Official EIP](https://eips.ethereum.org/EIPS/eip-4626)
- []()
- []()
- []()

## SelfDestruct.sol

This contract showcases EIP 6049 by allowing you test using it for yourself!

#### SelfDestruct Resources

- []()
- []()
- []()
- []()

## NFTMarket.sol

This contract showcases EIP 6105 by allowing you test using it for yourself!

#### NFTMarket Resources

- [Official EIP](https://eips.ethereum.org/EIPS/eip-6105)
- []()
- []()
- []()

## Merkle.sol

This contract showcases Merkle proofs by allowing you test using one for yourself!

#### Merkle Resources

- [Solidity-by-example](https://solidity-by-example.org/app/merkle-tree/)
- [State Trie](https://www.youtube.com/watch?v=OxofT39TJgg)
- [Ethereum Architecture Article](https://medium.com/@eiki1212/ethereum-state-trie-architecture-explained-a30237009d4e#:~:text=Trie%2C%20it%20is%20also%20called,data%20structure%20of%20data%20storage.)
- []()

## .sol

This contract showcases EIP by allowing you test using for yourself!

#### Resources

- []()
- []()
- []()
- []()
