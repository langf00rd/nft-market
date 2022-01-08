// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

import "./IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarket {

    uint private _tokenCount;
    mapping(uint => Token) public tokens;

    struct Token {
        address token;
        address seller;
        TokenStatus status;
        uint price;
        uint tokenID;
    }

    enum TokenStatus {
        Active,
        Cancelled
    }

    event TokenSent();
    event TokenAdded();
    event TokenCancelled();

    function addToken(address _token, uint _price) external payable {
        _tokenCount++;
        
        IERC721(_token).transferFrom(msg.sender, address(this), _tokenCount);

        Token memory newToken = Token(_token, msg.sender, TokenStatus.Active , _price, _tokenCount);
        tokens[_tokenCount] = newToken;
        
    }

    function cancelToken(uint _tokenID) external {
        Token storage _token = tokens[_tokenID];

        require (_token.status == TokenStatus.Active, "NFT is inactive");
        tokens[_tokenID].status = TokenStatus.Cancelled;
    }

    function activateToken(uint _tokenID) external {
        Token storage _token = tokens[_tokenID];

        require (_token.status == TokenStatus.Cancelled, "NFT is inactive");
        tokens[_tokenID].status = TokenStatus.Active;
    
    }

    function buyToken(uint _tokenID) external payable {
        Token storage _token = tokens[_tokenID];

        require (_token.status == TokenStatus.Active, "NFT is inactive");
        require (msg.sender != _token.seller, "Seller can't buy their own NFT");
        require (msg.value >= _token.price, "Insufficient amount");
        
        IERC721(_token.token).transferFrom(address(this), msg.sender, _tokenCount);

        // payable(_token.seller).transfer(_token.price);
    }

    function getToken(uint _tokenID) external view returns(Token memory) {
        return tokens[_tokenID];
    }
}
