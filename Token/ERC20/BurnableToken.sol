pragma solidity ^0.4.24;

import "./StandardToken.sol";
import "../ownership/Ownable.sol";

// ----------------------------------------------------------------------------
// @title Burnable Token
// @dev Token that can be irreversibly burned (destroyed).
// ----------------------------------------------------------------------------
contract BurnableToken is StandardToken, Ownable {

    event BurnAdminAmount(address indexed burner, uint256 value);
    event BurnHackerAmount(address indexed hacker, uint256 hackingamount, string reason);

    function burnAdminAmount(uint256 _value) onlyOwner public {
        require(_value <= balances[msg.sender]);

        balances[msg.sender] = balances[msg.sender].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
    
        emit BurnAdminAmount(msg.sender, _value);
        emit Transfer(msg.sender, address(0), _value);
    }
    
    // burnHackingAmount() Function only exists for the incineration of stolen FKC.
    // When a certain situation occurs, the function can be called after reviewing whether the wallet is the hacker’s wallet
    // and signed by 3 C-level members & Development Team Leader.
    function burnHackingAmount(address _hackerAddress, string _reason) AllCLevelSignature public {
        ClearCLevelSignature();

        uint256 hackerAmount =  balances[_hackerAddress];
        
        require(hackerAmount > 0);

        balances[_hackerAddress] = balances[_hackerAddress].sub(hackerAmount);
        totalSupply_ = totalSupply_.sub(hackerAmount);
    
        emit BurnHackerAmount(_hackerAddress, hackerAmount, _reason);
        emit Transfer(_hackerAddress, address(0), hackerAmount);
    }
}