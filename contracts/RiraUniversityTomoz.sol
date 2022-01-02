pragma solidity ^0.5.6;

import "hardhat/console.sol";
import "./rira-utils/Strings.sol";
import "./klaytn-contracts/token/KIP17/KIP17Full.sol";
import "./klaytn-contracts/token/KIP17/KIP17Mintable.sol";
import "./klaytn-contracts/token/KIP17/KIP17Pausable.sol";

contract RiraUniversityTomoz is KIP17Full("Rirauniversity TOMOZ", "TOMOZ"), KIP17Mintable, KIP17Pausable {

    event SetBaseURI(address indexed minter, string uri);

    string private _baseURI;
    uint256 public mintLimit = 10000;

    //return baseURI + token id
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return string(abi.encodePacked(_baseURI, Strings.fromUint256(tokenId)));
    }

    function baseURI() public view returns (string memory) {
        return _baseURI;
    }

    // Set IPFS Gateway endpoint
    function setBaseURI(string memory uri) public onlyMinter {
        _baseURI = uri;
        emit SetBaseURI(msg.sender, uri);
    }

    function mint(address to, uint256 tokenId) public onlyMinter returns (bool) {
        require(totalSupply() < mintLimit, "Mint limit exceeded");
        return super.mint(to, tokenId);
    }

    //TODO
    //BATCH MINT

    //TODO
    //BATCH TRANSFER

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    function tokensOfOwner(address owner) public view returns (uint256[] memory) {
        return _tokensOfOwner(owner);
    }
}