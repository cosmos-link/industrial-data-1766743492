// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract IndustrialDataStorage {
    struct IndustrialData {
        address factory;
        string equipmentId;
        string dataHash;
        string dataType;
        uint256 timestamp;
        uint8 quality;
    }

    mapping(uint256 => IndustrialData) public records;
    uint256 public recordCount;

    event DataStored(
        uint256 indexed id,
        address indexed factory,
        string equipmentId,
        string dataHash
    );

    function storeData(
        string memory _equipmentId,
        string memory _dataHash,
        string memory _dataType,
        uint8 _quality
    ) public returns (uint256) {
        recordCount++;

        records[recordCount] = IndustrialData({
            factory: msg.sender,
            equipmentId: _equipmentId,
            dataHash: _dataHash,
            dataType: _dataType,
            timestamp: block.timestamp,
            quality: _quality
        });

        emit DataStored(
            recordCount,
            msg.sender,
            _equipmentId,
            _dataHash
        );

        return recordCount;
    }
}