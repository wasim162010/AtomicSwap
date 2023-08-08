const SwapEtherToBitcoin = artifacts.require("SwapEtherToBitcoin");


const { deployProxy } = require('@openzeppelin/truffle-upgrades');
 
module.exports = async function (deployer) {
  await deployProxy(SwapEtherToBitcoin, { deployer });
};

// module.exports = function(deployer) {
//   deployer.deploy(SwapEtherToBitcoin);

// };
