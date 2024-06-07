// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; // version

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter {


    function getPrice() internal view returns(uint256) {
        // ABI
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        return uint256(price * 1e10); // Adjusting to 18 decimal places
    }

    function getConversionRate(uint256 usdAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (usdAmount * 1e18) / ethPrice;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

}