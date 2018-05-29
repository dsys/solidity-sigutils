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