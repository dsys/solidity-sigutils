# solidity-sigutils

![Travis](https://img.shields.io/travis/cleargraphinc/solidity-sigutils.svg) 
![npm](https://img.shields.io/npm/v/solidity-sigutils.svg)

Solidity library for (multi)signatures.

## Usage

[API Reference](#api-reference)

Install using npm:

    $ npm install --save solidity-sigutils

Then, in your solidity file, use the library:

```solidity
import "solidity-sigutils/contracts/SignatureUtils.sol";

contract MyContract {

    function myFunction(
        string _personalMessage,
        bytes _signatures
    ) public returns (address[]) {
        bytes32 hash = SignatureUtils.toEthPersonalSignedMessageHash(_personalMessage);
        return SignatureUtils.recoverAddresses(hash, _signatures);
    }

}
```

## Development

To install dependencies and start the local development server:

    $ yarn install
    $ yarn run migrate
    $ yarn start

### Testing

    $ yarn test
    $ yarn run watch # requires watchman: brew install watchman

### Static analysis with Mythril

    $ make install-mythril
    $ make myth

## License

Apache 2.0

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


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes32* | _hash | undefined |
| *bytes* | _signatures | undefined |
| *uint256* | _pos | undefined |


## *function* countSignatures

SignatureUtils.countSignatures(_signatures) `pure` `33ae3ad0`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes* | _signatures | undefined |


## *function* parseSignature

SignatureUtils.parseSignature(_signatures, _pos) `pure` `b31d63cc`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes* | _signatures | undefined |
| *uint256* | _pos | undefined |


## *function* toEthPersonalSignedMessageHash

SignatureUtils.toEthPersonalSignedMessageHash(_msg) `pure` `d8a40f6b`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes* | _msg | undefined |


## *function* toEthBytes32SignedMessageHash

SignatureUtils.toEthBytes32SignedMessageHash(_msg) `pure` `e5990d20`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes32* | _msg | undefined |


## *function* uintToString

SignatureUtils.uintToString(v) `pure` `e9395679`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | v | undefined |


## *function* recoverAddresses

SignatureUtils.recoverAddresses(_hash, _signatures) `pure` `f0c8e969`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *bytes32* | _hash | undefined |
| *bytes* | _signatures | undefined |


---