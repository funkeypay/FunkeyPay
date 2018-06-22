pragma solidity ^0.4.24;

// ----------------------------------------------------------------------------
// @title Ownable
// @dev The Ownable contract has an owner address, and provides basic authorization control
// functions, this simplifies the implementation of "user permissions".
// ----------------------------------------------------------------------------
contract Ownable {
    address public owner;
    address public operator;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event OperatorTransferred(address indexed previousOperator, address indexed newOperator);

    /**
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender
    * account.
    */
    constructor() public {
        owner = msg.sender;
        operator = msg.sender;
    }

    /**
    * @dev Throws if called by any account other than the owner & operator
    */

    modifier onlyOwner() { require(msg.sender == owner); _; }
    modifier onlyOwnerOrOperator() { require(msg.sender == owner || msg.sender == operator); _; }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param _newOwner The address to transfer ownership to.
    */
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0));
        owner = _newOwner;
        emit OwnershipTransferred(owner, _newOwner);
    }
  
    function transferOperator(address _newOperator) public onlyOwner {
        require(_newOperator != address(0));
        operator = _newOperator;
        emit OperatorTransferred(operator, _newOperator);
    }
}