# solidity-sigutils

![Travis](https://img.shields.io/travis/cleargraphinc/solidity-sigutils.svg) 
![npm](https://img.shields.io/npm/v/solidity-sigutils.svg)

A solidity library for verifying Ethereum message multi-signatures.

These utilities make it simple to interact with Ethereum signed messages based on [EIP 191](https://github.com/ethereum/EIPs/issues/191). They are especially useful for multi-sig self-sovereign identity contracts based on [ERC 1077](https://github.com/ethereum/EIPs/pull/1077). They are a building block for Cleargraph's open and decentralized identity system, and can be used for many other purposes in decentralized applications.

You can sign a transaction/message using your private key by calling [web3.personal.sign()](https://web3js.readthedocs.io/en/1.0/web3-eth-personal.html) using MetaMask, Toshi, or another compatible web3 runtime. All signatures are 65 bytes long with the format `{bytes32 r}{bytes32 s}{uint8 v}`. Multiple signatures are stored densely (no padding) by concatenating them.

## Usage

[API Reference](#api-reference)

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

[Check out the tests for more examples.](https://github.com/cleargraphinc/solidity-sigutils/blob/master/test/TestSignatureUtils.sol)

## Working with Ethereum Signed Messages

Signed messages are becoming an increasingly important part of decentralized applications, especially for identity management. Imagine a user wishes to perform a transaction on the Ethereum chain, but does not posses ether and therefore cannot pay for gas costs. One emerging solution is to use signed messages, a proxy contract, and a gas relay service. Here's how it goes:

1. A user wishes to perform a transaction and signs a message with the transaction details using their private key.
2. The user sends the transaction details and signature to a relay service off-chain.
3. The relay verifies the message and executes it on the proxy contract, paying for gas costs.
4. The proxy contract verifies the transaction details and signature, reverting if invalid.
5. The proxy contract performs the transaction.

Because signed messages inherit the security of Ethereum's `ecrecover()`, a user does not need to trust a gas relay with their private key to perform actions on their behalf. Many relay implementations require that a signature be signed with a private key on an address whitelist. Additionally, self-sovereign identity contracts may require multiple signatures for the same message to be valid.

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

## License

Apache 2.0

# API Reference
