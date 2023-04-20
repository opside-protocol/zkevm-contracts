// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.17;

import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

import { ISlotAdapter } from "../interfaces/ISlotAdapter.sol";


contract SlotAdapterMock is ISlotAdapter, OwnableUpgradeable {
    error OnlyZkEvmContract();
    event DistributeRewards(uint256 _slotId, address indexed _caller, address indexed _to, uint256 _amount); 

    address public zkEvmContract;

    uint256 public slotId;

    function initialize() external initializer {
        __Ownable_init_unchained();
    }

    modifier onlyZkEvmContract() {
        if (zkEvmContract != msg.sender) {
            revert OnlyZkEvmContract();
        }
        _;
    }

    function setZkevmContract(address _zkEvmContract) external onlyOwner {
        zkEvmContract = _zkEvmContract;
    }

    function distributeRewards(address _recipient, uint256 _amount) external onlyZkEvmContract {
       emit DistributeRewards(slotId, address(this), _recipient, _amount); 
    }
}
