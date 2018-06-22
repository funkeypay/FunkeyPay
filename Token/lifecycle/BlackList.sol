pragma solidity ^0.4.24;

import "../ownership/Ownable.sol";

// ----------------------------------------------------------------------------
// @title BlackList
// @dev Base contract which allows children to implement an emergency stop mechanism.
// ----------------------------------------------------------------------------
contract BlackList is Ownable {

    /**
    * Black List On Off
    */
    event Lock(address indexed LockedAddress);
    event Unlock(address indexed UnLockedAddress);

    mapping( address => bool ) public blackList;
    /**
    * @dev Modifier to make a function callable only when the contract is not paused.
    */
     modifier CheckBlackList {
        require(blackList[msg.sender] != true);
        _;
    }

    // Lock Address
    function SetLockAddress(address _lockAddress) external onlyOwner returns (bool) {
        require(_lockAddress != address(0));
        require(_lockAddress != owner);
        require(blackList[_lockAddress] != true);
        
        blackList[_lockAddress] = true;
        
        emit Lock(_lockAddress);

        return true;
    }

    function UnLockAddress(address _unlockAddress) external onlyOwner returns (bool) {
        require(_unlockAddress != address(0));
        require(_unlockAddress != owner);
        require(blackList[_unlockAddress] != false);
        
        blackList[_unlockAddress] = false;
        
        emit Unlock(_unlockAddress);

        return true;
    }
}