pragma solidity ^0.4.24;

// ----------------------------------------------------------------------------
// @title Ownable
// @dev There are 5 role groups for FunkeyCoin [FNK].
// If an exchange is hacked, all stolen FNK in the hacker’s wallet must be incinerated and given back to its original investors.
// However, incineration and reissuance of tokens for specific addresses are sensitive matters. 
// Therefore, it requires 4 signatures: 3 C-Level personnels and Development Team Leader. 
// Incineration and Reissuing tokens for specific addresses can only be used in case of hacking and cannot be used otherwise. 
// ----------------------------------------------------------------------------
contract Ownable {
    // Development Team Leader
    address public owner;
    // As the Funkeypay’s emergency standby personnel,
    // the person immediately blocks the transaction function of all tokens when an incident occurs.
    address public operator;

    // Has the authority to incinerate stolen tokens,
    // reissue tokens due to incineration, and reappoint C-Level members.
    address public CEO;                 
    address public CTO;
    address public CMO;

    bool public CEO_Signature;
    bool public CTO_Signature;
    bool public CMO_Signature;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event OperatorTransferred(address indexed previousOperator, address indexed newOperator);
    event CEOTransferred(address indexed previousCEO, address indexed newCEO);
    event CTOTransferred(address indexed previousCTO, address indexed newCTO);
    event CMOTransferred(address indexed previousCMO, address indexed newCMO);

    constructor() public {
        owner    = msg.sender;
        operator = 0xFd48048f8c7B900b5E5216Dc9d7bCd147c2E2efb;

        CEO = 0xAC9C29a58C54921e822c972ACb5EBA955B59C744;
        CTO = 0x60552ccF90872ad2d332DC26a5931Bc6BFb3142c;
        CMO = 0xff76E74fE7AC6Dcd9C151D57A71A99D89910a098;

        ClearCLevelSignature();
    }

    modifier onlyOwner() { require(msg.sender == owner); _; }
    modifier onlyOwnerOrOperator() { require(msg.sender == owner || msg.sender == operator); _; }
    modifier onlyCEO() { require(msg.sender == CEO); _; }
    modifier onlyCTO() { require(msg.sender == CTO); _; }
    modifier onlyCMO() { require(msg.sender == CMO); _; }
    modifier AllCLevelSignature() { require(msg.sender == owner && CEO_Signature && CTO_Signature && CMO_Signature); _; }

    function CEOSignature() external onlyCEO { CEO_Signature = true; }
    function CTOSignature() external onlyCTO { CTO_Signature = true; }
    function CMOSignature() external onlyCMO { CMO_Signature = true; }

    function transferOwnership(address _newOwner) external AllCLevelSignature {
        require(_newOwner != address(0));
        ClearCLevelSignature();
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }
  
    function transferOperator(address _newOperator) external onlyOwner {
        require(_newOperator != address(0));
        emit OperatorTransferred(operator, _newOperator);
        operator = _newOperator;
    }

    function transferCEO(address _newCEO) external AllCLevelSignature {
        require(_newCEO != address(0));
        ClearCLevelSignature();
        emit CEOTransferred(CEO, _newCEO);
        CEO = _newCEO;
    }

    function transferCTO(address _newCTO) external AllCLevelSignature {
        require(_newCTO != address(0));
        ClearCLevelSignature();
        emit CTOTransferred(CTO, _newCTO);
        CTO = _newCTO;
    }

    function transferCMO(address _newCMO) external AllCLevelSignature {
        require(_newCMO != address(0));
        ClearCLevelSignature();
        emit CMOTransferred(CMO, _newCMO);
        CMO = _newCMO;
    }

    function SignatureInvalidity() external onlyOwnerOrOperator {
        ClearCLevelSignature();
    }

    function ClearCLevelSignature() internal {
        CEO_Signature = false;
        CTO_Signature = false;
        CMO_Signature = false;
    }
}