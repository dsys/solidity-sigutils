# solidity-sigutils

Solidity library for (multi)signatures.

## Usage

    $ npm install --save solidity-sigutils

Then, in your solidity file:

```solidity
import "solidity-sigutils/contracts/SignatureUtils.sol";

contract MyContract {

    function myFunction(
        string _msg,
        bytes _signatures
    ) public returns (address[]) {
        bytes32 hash = SignatureUtils.toEthPersonalSignedMessageHash(_msg);
        return SignatureUtils.recoverAddresses(_msg, _signatures);
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
