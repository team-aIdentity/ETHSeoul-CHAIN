// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Profile is ERC721, ERC721URIStorage, Ownable {
    uint256 public _tokenId;
    string private _baseTokenURI;

    constructor(string memory baseURI)
        ERC721("Profile", "PRF")
        Ownable(msg.sender)
    {
        _baseTokenURI = baseURI;
    }


    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 newTokenId = _tokenId++;
        _safeMint(to, newTokenId);
        _setTokenURI(newTokenId, uri);
    }

    function nextId() external view returns(uint256) {
        return _tokenId;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    // The following functions are overrides required by Solidity.
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
