# solidity-sigutils

Solidity library for (multi)signatures.

## Usage

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
