// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract CryptoDevs is ERC721Enumerable, Ownable {
  string _baseTokenURI;

  IWhitelist whitelist;

bool public presaleStarted;

uint256 public presaleEnded;
uint256 public maxTokenIds =  20;
uint256 public tokenIds;
uint256 public _price = 0.01 ether;

bool public _paused;

modifier onlyWhenNotPaused{
  require(!_paused, "Contract currently paused");
  _;
}

  constructor(string memory baseURI, address whitelistContract) ERC721("Smart Devs", "SD"){
    _baseTokenURI = baseURI;
    whitelist = IWhitelist(whitelistContract);
  }

  function startPresale() public onlyOwner {
    presaleStarted = true;
    presaleEnded = block.timestamp + 5 minutes;
  }

  function presaleMint() public payable {
require(presaleStarted && block.timestamp < presaleEnded, "Presale Ended");
require(whitelist.whitelistedAddresses(msg.sender), "you are not in whitelist");
require(tokenIds < maxTokenIds, "Exceeded the limit");
require(msg.value >= _price, "Ether sent is not correct");

tokenIds += 1;

_safeMint(msg.sender, tokenIds);

  }

  function mint() public payable onlyWhenNotPaused{
require(presaleStarted && block.timestamp >= presaleEnded, "Presale Ended");
require(tokenIds < maxTokenIds, "Exceeded the limit");
require(msg.value >= _price, "Ether sent is notcorrect");

tokenIds += 1;

_safeMint(msg.sender, tokenIds);
  }
  
  function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI ;
    }

function withdraw() public onlyOwner{
  address _owner = owner();
  uint256 amount = address(this).balance;
  // the .call is used to send the ether to the address 
  (bool sent, ) = _owner.call{value: amount}("");
  require(sent, "Failed to send ether");
} 


function setPaused(bool val) public onlyOwner{
  _paused = val;
}


// it is call when sending ehter but not data
  receive() external payable {}
   

  // when sending ether with data as well
  fallback() external payable {}


}