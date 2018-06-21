pragma solidity ^0.4.24;

// ----------------------------------------------------------------------------
// @Project FunkeyCoin (FNK)
// @Creator Funkey Admin Ryu
// @Source Code Verification ()
// ----------------------------------------------------------------------------
import "../ERC20/PausableToken.sol";
import "../ERC20/MintableToken.sol";
import "../ERC20/BurnableToken.sol";
import "../ERC20/MultiTransferToken.sol";

contract FunkeyCoin is PausableToken, MintableToken, BurnableToken, MultiTransferToken {
  string public name = "FunkeyCoin";
  string public symbol = "FKC";
  uint256 public decimals = 18;
}