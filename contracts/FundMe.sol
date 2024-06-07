// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; // version

// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 50 * 1e18; // 50 USD, scaled up to 18 decimals

    function fund() public payable {
        uint256 minimumEthAmount = getConversionRate(minimumUsd);
        require(msg.value >= minimumEthAmount, "Didn't send enough!");
    }

    function getPrice() public view returns(uint256) {
        // ABI
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        return uint256(price * 1e10); // Adjusting to 18 decimal places
    }

    function getConversionRate(uint256 usdAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (usdAmount * 1e18) / ethPrice;
        return ethAmountInUsd;
    }

    // function withdraw() public {}
}
