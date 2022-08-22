// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {
    ExampleExternalContract public exampleExternalContract;

    mapping(address => uint256) public balances;
    mapping(address => uint256) public depositTimestamps;

    uint256 public constant rewarRatePerBlock = 0.1 ether;
    uint256 public withdrawalDeadline = block.timestamp + 120 seconds;
    uint256 public claimDeadline = block.timestamp + 240 seconds;
    uint256 public currentBlock = 0;

    event Stake(address indexed sender, uint256 amount);
    event Received(address, uint256);
    event Execute(address indexed sender, uint256 amount);

    constructor(address exampleExternalContractAddress) {
        exampleExternalContract = ExampleExternalContract(
            exampleExternalContractAddress
        );
    }

    function withdrawalTimeLeft()
        public
        view
        returns (uint256 _withdrawalTimeLeft)
    {
        if (block.timestamp >= withdrawalDeadline) {
            return 0;
        } else {
            return (withdrawalDeadline - block.timestamp);
        }
    }

    function claimPeriodLeft() public view returns (uint256 _claimPeriodLeft) {
        if (block.timestamp >= claimDeadline) {
            return 0;
        } else {
            return (claimDeadline - block.timestamp);
        }
    }
}
