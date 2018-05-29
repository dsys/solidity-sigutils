const SignatureUtils = artifacts.require('SignatureUtils')

module.exports = async function(deployer) {
  await deployer.deploy(SignatureUtils);
};
