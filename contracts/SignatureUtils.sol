pragma solidity ^0.4.23;

/// @title A library of utilities for (multi)signatures
/// @author Alexander Kern <alex@cleargraph.com>
library SignatureUtils {

    function toEthBytes32SignedMessageHash(
        bytes32 _msg
    )
        pure
        public
        returns (bytes32 signHash)
    {
        signHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _msg));
    }

    function toEthPersonalSignedMessageHash(
        bytes _msg
    )
        pure
        public
        returns (bytes32 signHash)
    {
        signHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n", uintToString(_msg.length), _msg));
    }

    function uintToString(
        uint v
    )
        pure
        public
        returns (string)
    {
        uint w = v;
        bytes32 x;
        if (v == 0) {
            x = "0";
        } else {
            while (w > 0) {
                x = bytes32(uint(x) / (2 ** 8));
                x |= bytes32(((w % 10) + 48) * 2 ** (8 * 31));
                w /= 10;
            }
        }

        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory resultBytes = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            resultBytes[j] = bytesString[j];
        }

        return string(resultBytes);
    }

    function parseSignature(
        bytes _signatures,
        uint _pos
    )
        pure
        public
        returns (uint8 v, bytes32 r, bytes32 s)
    {
        uint offset = _pos * 65;
        // The signature format is a compact form of:
        //   {bytes32 r}{bytes32 s}{uint8 v}
        // Compact means, uint8 is not padded to 32 bytes.
        assembly { // solium-disable-line security/no-inline-assembly
            r := mload(add(_signatures, add(32, offset)))
            s := mload(add(_signatures, add(64, offset)))
            // Here we are loading the last 32 bytes, including 31 bytes
            // of 's'. There is no 'mload8' to do this.
            //
            // 'byte' is not working due to the Solidity parser, so lets
            // use the second best option, 'and'
            v := and(mload(add(_signatures, add(65, offset))), 0xff)
        }

        require(v == 27 || v == 28);
    }

    function countSignatures(
        bytes _signatures
    )
        pure
        public
        returns (uint)
    {
        return _signatures.length % 65 == 0 ? _signatures.length / 65 : 0;
    }

    function recoverAddress(
        bytes32 _hash,
        bytes _signatures,
        uint _pos
    )
        pure
        public
        returns (address)
    {
        uint8 v;
        bytes32 r;
        bytes32 s;
        (v, r, s) = parseSignature(_signatures, _pos);
        return ecrecover(_hash, v, r, s);
    }

    function recoverAddresses(
        bytes32 _hash,
        bytes _signatures
    )
        pure
        public
        returns (address[] addresses)
    {
        uint8 v;
        bytes32 r;
        bytes32 s;
        uint count = countSignatures(_signatures);
        addresses = new address[](count);
        for (uint i = 0; i < count; i++) {
            (v, r, s) = parseSignature(_signatures, i);
            addresses[i] = ecrecover(_hash, v, r, s);
        }
    }

}
