//SPDX-License-Identifier: MIT

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "./GameNFT.sol";

pragma solidity ^0.8.0;
contract Game is Ownable{

    uint256 public game_id;

    struct GameInfo {
        string uri;
        GameNFT game_nft;
        uint256 number_amount;
        uint256 remaining_number_amount;
        uint256 start_timestamp;
    }

    mapping(uint256 => GameInfo) public game;

    event CreateGame(uint256,string,uint256,uint256);
    event MintNumber(uint256,uint256,address,string);

    function create_game(string memory _name,string memory _symbol,string memory _uri,uint256  _number_amount,uint256 _start_timestamp) public onlyOwner {
        GameNFT game_nft = new GameNFT(_name,_symbol);
        game[game_id] = GameInfo(_uri,game_nft,_number_amount,_number_amount+1,_start_timestamp);
        game_id++;
        emit CreateGame(game_id,_uri,_number_amount,_start_timestamp);
    }

    function mint_number(uint256 _game_id, uint256 _number,address _to,string memory _uri) public {
        GameInfo storage game_info = game[_game_id];
        require(game_info.start_timestamp >= block.timestamp,"Game: Game has started or no game");
        require(game_info.remaining_number_amount > 0,"Game: No quantity");
        game_info.game_nft.mint(_number,_to,_uri);
        game_info.remaining_number_amount--;
        emit MintNumber(_game_id,_number,_to,_uri);
    }

    function game_uri(uint256 _game_id) public view returns(string memory) {
        return game[_game_id].uri;
    }
    function nft_uri(uint256 _game_id,uint256 _number) public view returns(string memory) {
        return game[_game_id].game_nft.nft_uri(_number);
    }
}
