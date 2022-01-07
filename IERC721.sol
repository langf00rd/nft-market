// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

interface IERC721 {
    function transferFrom(address from, address to, uint tokenID) external;
}