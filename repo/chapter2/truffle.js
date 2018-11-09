// Allows us to use ES6 in our migrations and tests.
require('babel-register')

module.exports = {
  networks: {
    development: {          //这是开发网络，此外还有私有网络、测试网或公网
      host: '127.0.0.1',            //声明要连接的以太坊节点地址
      port: 8545,
      network_id: '*', // Match any network id
      gas:470000      //当调用deploy()方法部署一个合约时，如果没有声明愿意承担的油费，那么Truffle就会采用这个值作为该合约的部署油资。
    }
  }
}
