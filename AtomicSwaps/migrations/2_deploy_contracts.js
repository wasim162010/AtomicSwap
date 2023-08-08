const SwapERC20ToERC20 = artifacts.require("SwapERC20ToERC20");

const { deployProxy } = require('@openzeppelin/truffle-upgrades');
 
module.exports = async function (deployer) {
  await deployProxy(SwapERC20ToERC20, { deployer });
};


// module.exports = function(deployer) {
//   deployer.deploy(SwapERC20ToERC20);

// };
