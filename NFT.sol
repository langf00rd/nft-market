// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract NFT is ERC721 {
    uint private _counter;

    constructor () public ERC721 ("MetaLegion", "ML") {}

    function mint () external returns (uint) {
        _counter++;
        _mint(msg.sender, _counter);
        _approve(msg.sender, _counter);

        return _counter;
    }
}
