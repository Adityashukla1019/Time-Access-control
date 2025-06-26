// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TimeAccessControl {
    address public owner;
    mapping(address => uint256) public accessExpiry;

    event AccessGranted(address indexed user, uint256 expiry);
    event AccessRevoked(address indexed user);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier hasAccess() {
        require(block.timestamp < accessExpiry[msg.sender], "Access expired");
        _;
    }

    function grantAccess(address _user, uint256 _durationInSeconds) external onlyOwner {
        accessExpiry[_user] = block.timestamp + _durationInSeconds;
        emit AccessGranted(_user, accessExpiry[_user]);
    }

    function revokeAccess(address _user) external onlyOwner {
        accessExpiry[_user] = 0;
        emit AccessRevoked(_user);
    }

    function checkAccess() external view returns (bool) {
        return block.timestamp < accessExpiry[msg.sender];
    }

    function accessProtectedResource() external hasAccess view returns (string memory) {
        return "You have access to the protected resource!";
    }
}
