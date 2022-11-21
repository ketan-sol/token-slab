// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract tokenSlab is ERC20, Ownable {
    uint256[5] slabs;
    mapping(address => string[]) depositEnquiry;

    constructor() ERC20("MockToken", "MT") {
        _mint(msg.sender, 1500 * 10**decimals());
    }

    function totalDeposit() public view returns (uint256) {
        return slabs[0] + slabs[1] + slabs[2] + slabs[3] + slabs[4];
    }

    function deposit(uint256 tokenAmount) public returns (string memory) {
        if (tokenAmount > 0) {
            if (totalDeposit() + tokenAmount <= 1500 && tokenAmount > 0) {
                uint256 tokensLeft = tokenAmount;

                if ((500 - slabs[4]) > 0) {
                    if ((500 - slabs[4]) >= tokensLeft) {
                        slabs[4] = slabs[4] + tokensLeft;
                        tokensLeft = 0;
                        depositEnquiry[msg.sender].push("Slab 5");
                        return "Tokens deposited in slab 5";
                    } else {
                        tokensLeft = tokensLeft - (500 - slabs[4]);
                        slabs[4] = 500;
                        depositEnquiry[msg.sender].push("Slab 5");
                    }
                }

                if ((400 - slabs[3]) > 0) {
                    if ((400 - slabs[3]) >= tokensLeft) {
                        slabs[3] = slabs[3] + tokensLeft;
                        tokensLeft = 0;
                        depositEnquiry[msg.sender].push("Slab 4");
                        return "Tokens deposited in slab 4";
                    } else {
                        tokensLeft = tokensLeft - (400 - slabs[3]);
                        slabs[3] = 400;
                        depositEnquiry[msg.sender].push("Slabs 4");
                    }
                }

                if ((300 - slabs[2]) > 0) {
                    if ((300 - slabs[2]) >= tokensLeft) {
                        slabs[2] = slabs[2] + tokensLeft;
                        tokensLeft = 0;
                        depositEnquiry[msg.sender].push("Slab 3");
                        return "Tokens deposited in slab 3";
                    } else {
                        tokensLeft = tokensLeft - (300 - slabs[2]);
                        slabs[2] = 300;
                        depositEnquiry[msg.sender].push("Slab 3");
                    }
                }

                if ((200 - slabs[1]) > 0) {
                    if ((200 - slabs[1]) >= tokensLeft) {
                        slabs[1] = slabs[1] + tokensLeft;
                        tokensLeft = 0;
                        depositEnquiry[msg.sender].push("slab 2");
                        return "Tokens deposited in slab 2";
                    } else {
                        tokensLeft = tokensLeft - (200 - slabs[1]);
                        slabs[1] = 200;
                        depositEnquiry[msg.sender].push("Slab 2");
                    }
                }

                if ((100 - slabs[0]) > 0) {
                    if ((100 - slabs[0]) >= tokensLeft) {
                        slabs[0] = slabs[0] + tokensLeft;
                        tokensLeft = 0;
                        depositEnquiry[msg.sender].push("Slab 1");
                        return "Tokens deposited in slab 1";
                    } else {
                        tokensLeft = tokensLeft - (100 - slabs[0]);
                        slabs[0] = 100;
                        depositEnquiry[msg.sender].push("Slab 1");
                    }
                }
            } else {
                if (tokenAmount > 1500) {
                    return "Amount must be less than 1500";
                } else return "Storage full";
            }
        } else {
            return "Amount must be greater than 0";
        }
        return "ERROR";
    }

    function getTokenSlab(address wallet)
        public
        view
        returns (string[] memory)
    {
        return depositEnquiry[wallet];
    }
}
