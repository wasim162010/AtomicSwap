const TestERC20 = artifacts.require("TestERC20");

const { deployProxy } = require('@openzeppelin/truffle-upgrades');
 

module.exports = async function (deployer) {
  await deployProxy(TestERC20, { deployer , initializer: 'init'});
};


// module.exports = function(deployer) {
//   deployer.deploy(TestERC20);

// };
