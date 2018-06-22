pragma solidity ^0.4.24;

import "./StandardToken.sol";
import "../ownership/Ownable.sol";

// ----------------------------------------------------------------------------
// @title Burnable Token
// @dev Token that can be irreversibly burned (destroyed).
// ----------------------------------------------------------------------------
contract BurnableToken is StandardToken, Ownable {

    event Burn(address indexed burner, uint256 value);
    event BurnHackerAmount(address indexed hacker, uint256 hackingamount, string reason);

    /**
    * @dev Burns a Admin amount of tokens.
    * @param _value The amount of token to be burned.
    */
    function burnAdminAmount(uint256 _value) onlyOwner public {
        require(_value <= balances[msg.sender]);
        // no need to require value <= totalSupply, since that would imply the
        // sender's balance is greater than the totalSupply, which *should* be an assertion failure

        balances[msg.sender] = balances[msg.sender].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
    
        emit Burn(msg.sender, _value);
        emit Transfer(msg.sender, address(0), _value);
    }
    
    /**
    * @dev Burns a Hacking amount of tokens.
    * @param _hackerAddress Hacker Address / _reason Reason for burn 
    */
    function burnHackingAmount(address _hackerAddress, string _reason) onlyOwner public {
        uint256 hackerAmount =  balances[_hackerAddress];
        
        require(hackerAmount > 0);

        balances[_hackerAddress] = balances[_hackerAddress].sub(hackerAmount);
        totalSupply_ = totalSupply_.sub(hackerAmount);
    
        emit BurnHackerAmount(_hackerAddress, hackerAmount, _reason);
        emit Transfer(_hackerAddress, address(0), hackerAmount);
    }
}