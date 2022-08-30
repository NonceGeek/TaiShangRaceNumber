//SPDX-License-Identifier: MIT

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

pragma solidity ^0.8.0;

contract GameNFT is ERC721Enumerable{
    address public game;
    mapping(uint256 => string) public nft_uri;
    constructor(string memory _name, string memory _symbol) ERC721(_name,_symbol) {
        game = msg.sender;
    }

    function mint(uint256 _number,address _to,string memory _uri) public {
        require(msg.sender == game,"GameNFT: No permission");
        _mint(_to,_number);
        nft_uri[_number] = _uri;
    }
}
