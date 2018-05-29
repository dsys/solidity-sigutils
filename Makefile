.PHONY: install-mythril
install-mythril:
	brew tap ethereum/ethereum
	brew install leveldb solidity
	pip3 install mythril

.PHONY: myth
myth:
	myth -x contracts/SimpleIdentityProvider.sol
	myth -x contracts/policies/SimpleWhitelistPolicy.sol
