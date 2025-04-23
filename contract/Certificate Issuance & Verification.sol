// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateRegistry {
    address public owner;

    struct Certificate {
        string studentName;
        string courseName;
        uint256 issueDate;
        bool isValid;
    }

    mapping(bytes32 => Certificate) public certificates;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function issueCertificate(
        string memory _studentName,
        string memory _courseName,
        uint256 _issueDate
    ) public onlyOwner returns (bytes32) {
        bytes32 certHash = keccak256(abi.encodePacked(_studentName, _courseName, _issueDate));
        certificates[certHash] = Certificate(_studentName, _courseName, _issueDate, true);
        return certHash;
    }

    function verifyCertificate(bytes32 certHash) public view returns (bool) {
        return certificates[certHash].isValid;
    }
}

