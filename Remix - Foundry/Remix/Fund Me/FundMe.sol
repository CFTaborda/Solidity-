// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

// import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import { PriceConverter } from "./PriceConverter.sol";

uint256 constant MINIMUM_USD = 5 * 1e18;
error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = MINIMUM_USD;

    address[] public funders;

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner; // immutable use i_ prefix

    constructor() {
        i_owner = msg.sender;
    }

    // uint256 public myValue = 1; previous state to Revert
    // Revert state spend gas but not change state
    function fund()  public payable{
        // Allow users to send $
        // Have a minimum $ sent
        // How do we send ETH to this contract?
        
        // Revert = myValue = myValue + 1; come back to the previous state 

        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // for loop
        // (1, 2, 3, ..., n) elements
        // 0, 1, 2, 3, ..., n-1 indexes
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);

        // actually withdraw the funds
        // // transfer
        // msg.sender = address
        // payable(msg.sender) = payable address
        // // payable(msg.sender).transfer(address(this).balance);
        // // send
        // // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // // require(sendSuccess, "Send failed");
        // // call
        // CALL is the recomended way to send and received ETH native tokens
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");

    }

    modifier onlyOwner {
        if (msg.sender != i_owner) revert NotOwner();
        _; // This _; means to run the rest of the code in the function where this modifier is used
        
    }
        
}