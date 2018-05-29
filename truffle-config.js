const PrivateKeyProvider = require('truffle-privatekey-provider');
const web3 = require('web3')

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 9545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      provider: () => new PrivateKeyProvider(process.env.INFURA_PRIVATE_KEY, `https://rinkeby.infura.io/${process.env.INFURA_API_KEY}`),
      network_id: 4,
      gas: 4612388 // Gas limit used for deploys
    },
    mainnet: {
      provider: () => new PrivateKeyProvider(process.env.INFURA_PRIVATE_KEY, `https://mainnet.infura.io/${process.env.INFURA_API_KEY}`),
      network_id: 0,
      gas: 4612388, // Gas limit used for deploys,
      gasPrice: 9 * 1000000000
    }
  },
  mocha: {
    reporter: 'eth-gas-reporter',
    reporterOptions: {
      currency: 'USD'
    }
  }

  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
};
