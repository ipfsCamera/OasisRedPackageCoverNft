pragma solidity ^0.6.0;
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract ERC20 {

  using SafeMath for uint256;
  using SafeMath for uint8;

  address public owner;
  //total Supply
  uint256 private _totalSupply;
  //balance of each user
  mapping (address => uint256) private _balances;
  mapping (address => mapping (address => uint256)) private _allowance;
  string private _name;
  string private _symbol;
  uint8 private _decimals;
  event Transfer(address indexed from, address indexed to,uint256 value);

  constructor(string memory _myName,string memory _mySymbol,uint8 _myDecimals,uint256 _myTotalSupply) public {
    owner = msg.sender;
    _name = _myName;
    _symbol = _mySymbol;
    _decimals = _myDecimals;
    _totalSupply = _myTotalSupply * 10 ** uint256(_myDecimals);
    _balances[msg.sender] = _balances[msg.sender].add(_totalSupply);
  }

  function name() public view returns(string memory) {
    return _name;
  }
  function symbol() public view returns(string memory) {
    return _symbol;
  }
  function decimals() public view returns(uint8) {
    return _decimals;
  }
  function totalSupply() public view returns(uint256) {
    return _totalSupply;
  }
  function balanceOf(address account) public view returns(uint256) {
    return _balances[account];
  }
  function allowance(address owner,address spender) public view returns(uint256) {
    return _allowance[owner][spender];
  }

  function _transfer(address from,address to,uint256 value) private returns(bool) {
      require(from != address(0),"Error:transfer from 0 address");
      require(to != address(0),"Error:transfer to 0 address");
      
      _balances[from] = _balances[from].sub(value);
      _balances[to] = _balances[to].add(value);
      
      emit Transfer(from,to,value);
      return true;
  }
  function transfer(address to,uint256 value) public returns(bool) {
    return _transfer(msg.sender,to,value);
  }
  function transferFrom(address owner,address to,uint256 value) public returns(bool) {
      require(_allowance[owner][msg.sender] >= value,"Error:transferFrom fail");
      return _transfer(owner,to,value);
  }
}
