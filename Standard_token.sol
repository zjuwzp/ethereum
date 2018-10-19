pragma solidity ^0.4.20;

//定义接口合约
contract ERC20Interface {
  string public name;		//public会生成对应的get函数
  string public symbol;
  uint8 public  decimals;	//小数点位数
  uint public totalSupply;


  function transfer(address _to, uint256 _value) returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
  function approve(address _spender, uint256 _value) returns (bool success);
  function allowance(address _owner, address _spender) view returns (uint256 remaining);

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

contract ERC20 is ERC20Interface {		//is表示继承

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) internal allowed;	 //一个账号可操控另一个账号的金额

    constructor() public {
        totalSupply = 100000000;
        name = "MUKE Token";
        symbol = "IMOOC";
        decimals = 0;		//最小就是1个币，不能拆分成0.1个币
        balanceOf[msg.sender] = totalSupply;		//创建者拥有所有的代币
    }

  function balanceOf(address _owner) view returns (uint256 balance) {
      return balanceOf[_owner];
  }

    function transfer(address _to, uint _value) public returns (bool success) {
        require(_to != address(0));     //地址不能为0
        require(_value <= balanceOf[msg.sender]);
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);			//在转账完成之后需要发出Transfer事件
        return true;
    }

      function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        require(_to != address(0));
        require(_value <= balanceOf[_from]);
        require(_value <= allowed[_from][msg.sender]);
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
      }

  function approve(address _spender, uint256 _value) returns (bool success) {
          allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) view returns (uint256 remaining) {
      return allowed[_owner][_spender];
  }

}
