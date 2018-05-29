# solidity-sigutils

![Travis](https://img.shields.io/travis/dsys/solidity-sigutils.svg) 
![npm](https://img.shields.io/npm/v/solidity-sigutils.svg)

A solidity library for verifying Ethereum message multi-signatures.

These utilities make it simple to interact with Ethereum signed messages based on [EIP 191](https://github.com/ethereum/EIPs/issues/191). They are especially useful for multi-signature identity contracts based on [ERC 1077](https://github.com/ethereum/EIPs/pull/1077). They are a building block for Cleargraph's open and decentralized identity system, and can be used for many other purposes in decentralized applications.

You can sign a transaction/message using your private key by calling [web3.personal.sign()](https://web3js.readthedocs.io/en/1.0/web3-eth-personal.html) using MetaMask, Toshi, or another compatible web3 runtime. All signatures are 65 bytes long with the format `{bytes32 r}{bytes32 s}{uint8 v}`. Multiple signatures are stored densely (no padding) by concatenating them.

[API Reference](#api-reference) &middot; [Check out the tests for examples.](https://github.com/dsys/solidity-sigutils/blob/master/test/TestSignatureUtils.sol)

## Usage

[![solidity-sigutils flow](https://raw.githubusercontent.com/dsys/solidity-sigutils/master/resources/diagram.png)](#working-with-ethereum-signed-messages)

Signed messages are becoming an increasingly important part of decentralized applications, especially for identity management. Imagine a user wishes to perform a transaction (i.e. send a cryptokitty to a friend) on the Ethereum chain, but wants to require approval from two of their devices approve. One emerging solution is to use signed messages and a proxy contract. Here's how it goes:

1. The user signs a transaction message with their private key from multiple devices.
2. The user concatenates the message signatures into a single multi-signature.
3. The user sends the transaction message and concatenated signatures to their proxy verifier contract, which verifies that enough valid signatures have been provided using this library.
4. The proxy contract forwards the transaction to the designated contract.

Because signed messages inherit the security of Ethereum's `ecrecover()`, a user does not need to trust intermediaries with their private key to perform actions on their behalf. This enables more complex deployment strategies, such as gas relays which pay for gas costs on a user's behalf.

## Installation

Install using npm:

    $ npm install --save solidity-sigutils

Then, in your solidity file, use the library:

```solidity
import "solidity-sigutils/contracts/SignatureUtils.sol";

contract MyContract {

    using SignatureUtils for *; // optional

    function myFunction(
        string _personalMessage,
        bytes _signatures
    ) public returns (address[]) {
        // Generate the message hash according to EIP 191
        bytes32 hash = SignatureUtils.toEthPersonalSignedMessageHash(_personalMessage);

        // Returns the array of addresses which signed hash using their private key
        return SignatureUtils.recoverAddresses(hash, _signatures);
        // or use SignatureUtils.recoverAddress(hash, _signatures, 0) for only one signature
    }

}
```

## Development

PRs welcome. To install dependencies and start the local development server:

    $ npm install
    $ npm run migrate
    $ npm start

### Testing

    $ npm test
    $ npm run watch # requires watchman: brew install watchman

### Regenerate documentation

    $ npm run gen-docs

### Static analysis with Mythril

    $ make install-mythril
    $ make myth

## Coda

Licensed under Apache 2.0. Started at [ETHBuenosAires](https://ethbuenosaires.com/).

# API Reference
* [SignatureUtils](#signatureutils)
  * [recoverAddress](#function-recoveraddress)
  * [countSignatures](#function-countsignatures)
  * [parseSignature](#function-parsesignature)
  * [toEthPersonalSignedMessageHash](#function-toethpersonalsignedmessagehash)
  * [toEthBytes32SignedMessageHash](#function-toethbytes32signedmessagehash)
  * [uintToString](#function-uinttostring)
  * [recoverAddresses](#function-recoveraddresses)

# SignatureUtils

Alexander Kern <alex@cleargraph.com>

## *function* recoverAddress

SignatureUtils.recoverAddress(_hash, _signatures, _pos) `pure` `1c2a15b8`

**Recovers an address using a message hash and a signature in a bytes array.**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes32* | _hash | The signed message hash |
| *bytes* | _signatures | The signatures bytes array |
| *uint256* | _pos | The signature's position in the bytes array (0 indexed) |


## *function* countSignatures

SignatureUtils.countSignatures(_signatures) `pure` `33ae3ad0`

**Counts the number of signatures in a signatures bytes array. Returns 0 if the length is invalid.**

> Signatures are 65 bytes long and are densely packed.

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes* | _signatures | The signatures bytes array |


## *function* parseSignature

SignatureUtils.parseSignature(_signatures, _pos) `pure` `b31d63cc`

**Extracts the r, s, and v parameters to `ecrecover(...)` from the signature at position `_pos` in a densely packed signatures bytes array.**

> Based on [OpenZeppelin's ECRecovery](https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/ECRecovery.sol)

Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes* | _signatures | The signatures bytes array |
| *uint256* | _pos | The position of the signature in the bytes array (0 indexed) |


## *function* toEthPersonalSignedMessageHash

SignatureUtils.toEthPersonalSignedMessageHash(_msg) `pure` `d8a40f6b`

**Converts a byte array to a personal signed message hash (result of `web3.personal.sign(...)`) by concatenating its length.**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes* | _msg | The bytes array to encrypt |


## *function* toEthBytes32SignedMessageHash

SignatureUtils.toEthBytes32SignedMessageHash(_msg) `pure` `e5990d20`

**Converts a bytes32 to an signed message hash.**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes32* | _msg | The bytes32 message (i.e. keccak256 result) to encrypt |


## *function* uintToString

SignatureUtils.uintToString(v) `pure` `e9395679`

**Converts a uint to its decimal string representation.**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | v | The uint to convert |


## *function* recoverAddresses

SignatureUtils.recoverAddresses(_hash, _signatures) `pure` `f0c8e969`

**Recovers an array of addresses using a message hash and a signatures bytes array.**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes32* | _hash | The signed message hash |
| *bytes* | _signatures | The signatures bytes array |


---