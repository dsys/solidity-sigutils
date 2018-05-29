# solidity-sigutils

![Travis](https://img.shields.io/travis/dsys/solidity-sigutils.svg) 
![npm](https://img.shields.io/npm/v/solidity-sigutils.svg)

A solidity library for verifying Ethereum message multi-signatures.

These utilities make it simple to interact with Ethereum signed messages based on [EIP 191](https://github.com/ethereum/EIPs/issues/191) and [ERC 1077](https://github.com/ethereum/EIPs/pull/1077). They are a building block for Cleargraph's open and decentralized identity system, and can be used for many other purposes in decentralized applications.

You can sign a transaction/message using your private key by calling [web3.personal.sign()](https://web3js.readthedocs.io/en/1.0/web3-eth-personal.html) using MetaMask, Toshi, or another compatible web3 runtime. All signatures are 65 bytes long with the format `{bytes32 r}{bytes32 s}{uint8 v}`. Multiple signatures are stored densely (no padding) by concatenating them.

[API Reference](#api-reference) &middot; [Read the announcement.](https://medium.com/dsys/now-open-source-friendly-multi-signatures-for-ethereum-d75ca5a0dc5c) &middot; [See tests for examples.](https://github.com/dsys/solidity-sigutils/blob/master/test/TestSignatureUtils.sol)

## Usage

[![solidity-sigutils flow](https://raw.githubusercontent.com/dsys/solidity-sigutils/master/resources/diagram.png)](#working-with-ethereum-signed-messages)

[Signed messages](https://medium.com/@angellopozo/ethereum-signing-and-validating-13a2d7cb0ee3) are an increasingly important tool used by decentralized applications. They enable complex access management and delegation patterns and have greater flexibility than raw transactions. Wallet applications such as MetaMask and Toshi support signing transactions via their web3 provider which contracts can verify using `ecrecover()`.

In the context of identity management, signed messages play a crucial role in building more secure and accessible wallets. Conventionally, anyone with a user's private key has full control over their wallet. This is a security vulnerability: *any malicious actor with access to the user's private key can steal all funds.*

To improve security, it makes sense to require multi-factor approval from more than one device for some or all transactions. A so-called "multisig identity" often involves a proxy contract that accepts signed transactions from a whitelist of keys. To perform a multisig transaction:

1. **Sign:** The user signs a transaction message with their private key from multiple devices.
2. **Concatenate:** The user concatenates the message signatures into a single multi-signature.
3. **Verify:** The user sends the transaction message and concatenated signatures to their proxy verifier contract, which verifies that enough valid signatures have been provided using *solidity-sigutils*.
4. **Execute:** The proxy contract forwards the transaction to the designated contract.

Signed messages inherit the security of Ethereum's `web3.personal.sign()` and `ecrecover()`. One important benefit over raw transactions is that users can work with trust-less intermediaries without sharing their private keys. For example, signed messages enable complex transaction funding strategies like gas relays which pay for transaction costs on a user's behalf. Additionally, identity contracts may choose to use signed messages to implement advanced functionalities such as account recovery logic that does not rely on centralized authorities.

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
