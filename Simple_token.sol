pragma solidity ^0.4.20;

contract MyToken {
    mapping (address => uint256) public balanceOf;

    constructor(uint256 initialSupply) public {		//构造函数中需要传入代币的供应量
		//把所有的代币给创建者
        balanceOf[msg.sender] = initialSupply;              // Give the creator all initial tokens
    }

    function transfer(address _to, uint256 _value) public {
		//requie函数用于检查
        require(balanceOf[msg.sender] >= _value);           // Check if the sender has enough
		//如果溢出，则转账不能够执行
        require(balanceOf[_to] + _value >= balanceOf[_to]); // Check for overflows
        balanceOf[msg.sender] -= _value;                    // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
    }
}
