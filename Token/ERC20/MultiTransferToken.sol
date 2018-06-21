pragma solidity ^0.4.24;

import "./StandardToken.sol";
import "../ownership/Ownable.sol";

/**
 * @title MultiTransfer
 * @dev Only Admin
 **/
contract MultiTransferToken is StandardToken, Ownable {

  function MultiTransfer(address[] _to, uint256[] _amount) onlyOwner public returns (bool) {
    require(_to.length == _amount.length);

    uint256 ui;
    uint256 amountSum = 0;
    
    for (ui = 0; ui < _to.length; ui++){
      require(_to[i] != address(0));

      amountSum = amountSum.add(_amount[ui]);
    }

    require(amountSum <= balances[owner]);

    for (ui = 0; ui < _to.length; ui++){
      super.transfer(_to[ui], _amount[ui]);
    }
    return true;
  }
}