const Test2ERC20 = artifacts.require("Test2ERC20");

const { deployProxy } = require('@openzeppelin/truffle-upgrades');
 

module.exports = async function (deployer) {
  await deployProxy(Test2ERC20, { deployer, initializer: 'init'});
};


// module.exports = function(deployer) {
//   deployer.deploy(Test2ERC20);

// };
