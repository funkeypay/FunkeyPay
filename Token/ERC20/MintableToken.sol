pragma solidity ^0.4.24;

import "./StandardToken.sol";
import "../ownership/Ownable.sol";

// ----------------------------------------------------------------------------
// @title Mintable token
// @dev Simple ERC20 Token example, with mintable token creation
// Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
// ----------------------------------------------------------------------------
contract MintableToken is StandardToken, Ownable {
    event Mint(address indexed to, uint256 amount);
    event MintFinished();
    event MintRestarted(string reason);

    bool public mintingFinished = false;

    modifier canMint() { require(!mintingFinished); _; }
    modifier cannotMint() { require(mintingFinished); _; }

    function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
        totalSupply_ = totalSupply_.add(_amount);
        balances[_to] = balances[_to].add(_amount);
    
        emit Mint(_to, _amount);
        emit Transfer(address(0), _to, _amount);
    
        return true;
    }

    function finishMinting() onlyOwner canMint public returns (bool) {
        mintingFinished = true;
        emit MintFinished();
        return true;
    }

    // restartMinting() Function isn’t for just simple reissuing.
    // When the hacking occurs, all amount of FKC in the hacker's wallet
    // is incinerated and corresponding quantity of FKC will be reissued to the victims’ wallets.
    function restartMinting(string _reason) AllCLevelSignature cannotMint public returns (bool) {
        ClearCLevelSignature();

        mintingFinished = false;
        emit MintRestarted(_reason);
        return true;
    }
}