pragma solidity ^0.4.24;

// ----------------------------------------------------------------------------
// @Project FunkeyCoin (FNK)
// @Creator Johnson Ryu (Blockchain Core Developer)
// @Source Code Verification (CEO : JK JUNG / CTO : SeungWoo KANG)
// ----------------------------------------------------------------------------
import "../ERC20/PausableToken.sol";
import "../ERC20/MintableToken.sol";
import "../ERC20/BurnableToken.sol";
import "../ERC20/MultiTransferToken.sol";

contract FunkeyCoin is PausableToken, MintableToken, BurnableToken, MultiTransferToken {
    string public name = "FunkeyCoin";
    string public symbol = "FNK";
    uint256 public decimals = 18;
}