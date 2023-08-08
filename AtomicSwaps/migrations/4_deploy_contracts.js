const SwapEtherToERC20 = artifacts.require("SwapEtherToERC20");

const { deployProxy } = require('@openzeppelin/truffle-upgrades');
 
module.exports = async function (deployer) {
  await deployProxy(SwapEtherToERC20, { deployer });
};


// module.exports = function(deployer) {
//   deployer.deploy(SwapEtherToERC20);

// };
