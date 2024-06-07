// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; // version

// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

import "./PriceConverter.sol";


error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    //constant cheaper
    uint256 public constant MINIMUM_USD = 50 * 1e18; // 50 USD, scaled up to 18 decimals

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner=msg.sender; //whoever deploys the contract
    }

    function fund() public payable {
        // Use the getConversionRate function from the PriceConverter library
        uint256 minimumEthAmount = MINIMUM_USD.getConversionRate();
        require(msg.value >= minimumEthAmount, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{
        //require(msg.sender==owner,"Sender is not owner!");
        /* starting index, ending index, step amount */
        for(uint256 funderIndex=0; funderIndex<funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
         //reset array
        funders=new address[](0);
        //actually withdraw funds
        //1.transfer, msg.sender=address & payable(msg.sender)=payable address
        //payable(msg.sender).transfer(address(this).balance);
        //2.send
        //bool sendSuccess =  payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send failed");
        //3.call recommened way
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
        revert();
    }
    modifier onlyOwner {
        //require(msg.sender==i_owner, "Sender is not owner!");
        if(msg.sender!=i_owner){ revert NotOwner();}
        _; //rest of the code
    }
    // what happens if some1 sends this contract ETH without calling the fund function

    receive() external payable {
        fund();
    }
    
    fallback() external payable {
        fund();
    }
}
