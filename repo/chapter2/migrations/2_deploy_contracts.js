var Voting = artifacts.require("./Voting.sol");       //Truffle的artifacts对象自动调用solidity编译器来编译合约代码文件Voting.sol，Voting为编译结果对象

module.exports = function(deployer) {
  deployer.deploy(Voting,['Rama','Nick','Jose'],{gas:500000});
};
