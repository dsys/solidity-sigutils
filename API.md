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