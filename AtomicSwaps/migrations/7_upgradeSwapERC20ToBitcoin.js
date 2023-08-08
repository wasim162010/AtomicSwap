const SwapERC20ToBitcoin = artifacts.require('SwapERC20ToBitcoin');
const SwapERC20ToBitcoinv2 = artifacts.require('SwapERC20ToBitcoinV2');

const { prepareUpgrade } = require('@openzeppelin/truffle-upgrades');

module.exports = async function (deployer) {
    const SwapERC20ToBitcoinVar = await SwapERC20ToBitcoin.deployed();
    await prepareUpgrade(SwapERC20ToBitcoinVar.address, SwapERC20ToBitcoinv2, { deployer });
  };
 