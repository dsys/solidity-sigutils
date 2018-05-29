pragma solidity ^0.4.23;

import "truffle/Assert.sol";  
import "../contracts/SignatureUtils.sol";

contract TestSignatureUtils {

    function testToSignHash() public {
        Assert.equal(
            SignatureUtils.toEthBytes32SignedMessageHash(keccak256("foobar")),
            0xdffbffe3efcc512c9b93c698d46fecc2eca5e2836e6bd604aa6d1d3c815f1537,
            "The signature should be correct"
        );

        Assert.equal(
            SignatureUtils.toEthPersonalSignedMessageHash("foobar"),
            0xe01d3891dc951e1138097775e7606ec57253579693f93e9c8dc6b455e08b87ba,
            "The signature should be correct"
        );
    }

    function testParseSignature() public {
        uint8 v;
        bytes32 r;
        bytes32 s;

        (v, r, s) = SignatureUtils.parseSignature(hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451c", 0);
        Assert.equal(uint(v), 28, "V should be correct");
        Assert.equal(r, 0xbdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c8, "R should be correct");
        Assert.equal(s, 0x44fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be73345, "S should be correct");

        (v, r, s) = SignatureUtils.parseSignature(hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451ca3bee0d556bf8faa9923d33649b8dc601779c9b8f5bd0e18b243a56a696eacbd0740091f1321e33f929758645fd0bdbeea76017defc6e7742ffcefc73055ea991c", 0);
        Assert.equal(uint(v), 28, "V should be correct");
        Assert.equal(r, 0xbdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c8, "R should be correct");
        Assert.equal(s, 0x44fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be73345, "S should be correct");

        (v, r, s) = SignatureUtils.parseSignature(hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451ca3bee0d556bf8faa9923d33649b8dc601779c9b8f5bd0e18b243a56a696eacbd0740091f1321e33f929758645fd0bdbeea76017defc6e7742ffcefc73055ea991c", 1);
        Assert.equal(uint(v), 28, "V should be correct");
        Assert.equal(r, 0xa3bee0d556bf8faa9923d33649b8dc601779c9b8f5bd0e18b243a56a696eacbd, "R should be correct");
        Assert.equal(s, 0x0740091f1321e33f929758645fd0bdbeea76017defc6e7742ffcefc73055ea99, "S should be correct");
    }

    function testRecoverAddress() public {
        address addr = SignatureUtils.recoverAddress(
            SignatureUtils.toEthPersonalSignedMessageHash("foobar"),
            hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451c",
            0
        );

        Assert.equal(addr, 0x730392967a8b81b067459a449C23B2DF9CFC5e28, "Address should be correct");

        addr = SignatureUtils.recoverAddress(
            SignatureUtils.toEthPersonalSignedMessageHash("foobar"),
            hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451ca3bee0d556bf8faa9923d33649b8dc601779c9b8f5bd0e18b243a56a696eacbd0740091f1321e33f929758645fd0bdbeea76017defc6e7742ffcefc73055ea991c",
            0
        );

        Assert.equal(addr, 0x730392967a8b81b067459a449C23B2DF9CFC5e28, "Address should be correct");

        addr = SignatureUtils.recoverAddress(
            SignatureUtils.toEthPersonalSignedMessageHash("lacroixn"),
            hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451ca3bee0d556bf8faa9923d33649b8dc601779c9b8f5bd0e18b243a56a696eacbd0740091f1321e33f929758645fd0bdbeea76017defc6e7742ffcefc73055ea991c",
            1
        );

        Assert.equal(addr, 0x257555c08E8f81C6855FEE00ACA8Ef41C878D1CE, "Address should be correct");

        addr = SignatureUtils.recoverAddress(
            SignatureUtils.toEthPersonalSignedMessageHash("wrong"),
            hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451ca3bee0d556bf8faa9923d33649b8dc601779c9b8f5bd0e18b243a56a696eacbd0740091f1321e33f929758645fd0bdbeea76017defc6e7742ffcefc73055ea991c",
            0
        );

        Assert.notEqual(addr, 0x730392967a8b81b067459a449C23B2DF9CFC5e28, "Address should be incorrect");
    }

    function testCountSignatures() public {
        uint count = SignatureUtils.countSignatures(
            hex"bdaf"
        );
        Assert.equal(count, 0, "Signature count should be zero");

        count = SignatureUtils.countSignatures(
            hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451c"
        );
        Assert.equal(count, 1, "Signature count should be zero");

        count = SignatureUtils.countSignatures(
        hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451ca3bee0d556bf8faa9923d33649b8dc601779c9b8f5bd0e18b243a56a696eacbd0740091f1321e33f929758645fd0bdbeea76017defc6e7742ffcefc73055ea991c"
        );
        Assert.equal(count, 2, "Signature count should be correct");
    }

    function testRecoverAddresses() public {
        address[] memory addr = SignatureUtils.recoverAddresses(
            SignatureUtils.toEthPersonalSignedMessageHash("foobar"),
            hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451c45d89542a4c55bff03a799749a05c779861b306bb1e5cd45415ac05b666fa7c534ae29a8c7746da72b6d8dee6c69fc52b9c0448ea08ecb54d81cf934dff7372d1c"
        );

        Assert.equal(addr.length, 2, "Address count should be correct");
        Assert.equal(addr[0], 0x730392967a8b81b067459a449C23B2DF9CFC5e28, "Address 0 should be correct");
        Assert.equal(addr[1], 0x257555c08E8f81C6855FEE00ACA8Ef41C878D1CE, "Address 1 should be correct");

        addr = SignatureUtils.recoverAddresses(
            SignatureUtils.toEthPersonalSignedMessageHash("foobar"),
            hex"bdaf2b3265225e00f4df2a3a038bea2907c5f0194311a9449735e477971d54c844fe7bf6590dc048cd005ed6c070ca8eeda91a0636328136b5f36c656be733451ca3bee0d556bf8faa9923d33649b8dc601779c9b8f5bd0e18b243a56a696eacbd0740091f1321e33f929758645fd0bdbeea76017defc6e7742ffcefc73055ea991c"
        );

        Assert.equal(addr.length, 2, "Address count should be correct");
        Assert.equal(addr[0], 0x730392967a8b81b067459a449C23B2DF9CFC5e28, "Address 0 should be correct");
        Assert.notEqual(addr[1], 0x257555c08E8f81C6855FEE00ACA8Ef41C878D1CE, "Address 1 should be incorrect");

        addr = SignatureUtils.recoverAddresses(
            SignatureUtils.toEthPersonalSignedMessageHash("foobar"),
            hex"bdaf2b32652c"
        );
        Assert.equal(addr.length, 0, "Address count should be zero");
    }

}
