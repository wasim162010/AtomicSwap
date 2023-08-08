const SwapERC20ToBitcoin = artifacts.require("SwapERC20ToBitcoin");

const { deployProxy } = require('@openzeppelin/truffle-upgrades');
 
module.exports = async function (deployer) {
  await deployProxy(SwapERC20ToBitcoin, { deployer });
};

// module.exports = function(deployer) {
//   deployer.deploy(SwapERC20ToBitcoin);

// };
