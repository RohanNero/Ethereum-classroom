// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

/// Eventually replace these open zeppelin imports with my own contract imports 
/// Meaning you will need to add support for 2981 and Reentrancy Guard
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

interface IERC6105 {

  /// @notice Emitted when a token is listed for sale or delisted
  /// @dev The zero `salePrice` indicates that the token is not for sale
  ///      The zero `expires` indicates that the token is not for sale
  /// @param tokenId - identifier of the token being listed
  /// @param from - address of who is selling the token
  /// @param salePrice - the price the token is being sold for
  /// @param expires - UNIX timestamp, the buyer could buy the token before expires
  /// @param supportedToken - contract addresses of supported token or zero address
  ///                         The zero address indicates that the supported token is ETH
  ///                         Buyer needs to purchase item with supported token
  /// @param benchmarkPrice - Additional price parameter, may be used when calculating royalties
  event UpdateListing(
    uint256 indexed tokenId,
    address indexed from,
    uint256 salePrice,
    uint64 expires,
    address supportedToken,
    uint256 benchmarkPrice
    );

  /// @notice Emitted when a token is being purchased
  /// @param tokenId - identifier of the token being purchased
  /// @param from - address of who is selling the token
  /// @param to - address of who is buying the token 
  /// @param salePrice - the price the token is being sold for
  /// @param supportedToken - contract addresses of supported token or zero address
  ///                         The zero address indicates that the supported token is ETH
  ///                         Buyer needs to purchase item with supported token
  /// @param royalties - The amount of royalties paid on this purchase
  event Purchased(
    uint256 indexed tokenId,
    address indexed from,
    address indexed to,
    uint256 salePrice,
    address supportedToken,
    uint256 royalties
    );

  /// @notice Create or update a listing for `tokenId`
  /// @dev `salePrice` MUST NOT be set to zero
  /// @param tokenId - identifier of the token being listed
  /// @param salePrice - the price the token is being sold for
  /// @param expires - UNIX timestamp, the buyer could buy the token before expires
  /// @param supportedToken - contract addresses of supported token or zero address
  ///                         The zero address indicates that the supported token is ETH
  ///                         Buyer needs to purchase item with supported token
  /// Requirements:
  /// - `tokenId` must exist
  /// - Caller must be owner, authorised operators or approved address of the token
  /// - `salePrice` must not be zero
  /// - `expires` must be valid
  /// - Must emit an {UpdateListing} event.
  function listItem(
    uint256 tokenId,
    uint256 salePrice,
    uint64 expires,
    address supportedToken
    ) external;

  /// @notice Create or update a listing for `tokenId` with `benchmarkPrice`
  /// @dev `salePrice` MUST NOT be set to zero
  /// @param tokenId - identifier of the token being listed
  /// @param salePrice - the price the token is being sold for
  /// @param expires - UNIX timestamp, the buyer could buy the token before expires
  /// @param supportedToken - contract addresses of supported token or zero address
  ///                         The zero address indicates that the supported token is ETH
  ///                         Buyer needs to purchase item with supported token
  /// @param benchmarkPrice - Additional price parameter, may be used when calculating royalties
  /// Requirements:
  /// - `tokenId` must exist
  /// - Caller must be owner, authorised operators or approved address of the token
  /// - `salePrice` must not be zero
  /// - `expires` must be valid
  /// - Must emit an {UpdateListing} event.
  function listItem(
    uint256 tokenId,
    uint256 salePrice,
    uint64 expires,
    address supportedToken,
    uint256 benchmarkPrice
    ) external;
 
  /// @notice Remove the listing for `tokenId`
  /// @param tokenId - identifier of the token being delisted
  /// Requirements:
  /// - `tokenId` must exist and be listed for sale
  /// - Caller must be owner, authorised operators or approved address of the token
  /// - Must emit an {UpdateListing} event
  function delistItem(uint256 tokenId) external;
 
  /// @notice Buy a token and transfer it to the caller
  /// @dev `salePrice` and `supportedToken` must match the expected purchase price and token to prevent front-running attacks
  /// @param tokenId - identifier of the token being purchased
  /// @param salePrice - the price the token is being sold for
  /// @param supportedToken - contract addresses of supported token or zero address
  /// Requirements:
  /// - `tokenId` must exist and be listed for sale
  /// - `salePrice` must matches the expected purchase price to prevent front-running attacks
  /// - `supportedToken` must matches the expected purchase token to prevent front-running attacks
  /// - Caller must be able to pay the listed price for `tokenId`
  /// - Must emit a {Purchased} event
  function buyItem(uint256 tokenId, uint256 salePrice, address supportedToken) external payable;

  /// @notice Return the listing for `tokenId`
  /// @dev The zero sale price indicates that the token is not for sale
  ///      The zero expires indicates that the token is not for sale
  ///      The zero supported token address indicates that the supported token is ETH
  /// @param tokenId identifier of the token being queried
  /// @return the specified listing (sale price, expires, supported token, benchmark price)
  function getListing(uint256 tokenId) external view returns (uint256, uint64, address, uint256);
}

// list
error SalePriceCannotBeZero();
error InvalidExpiresTimestamp();
error CallerIsntOwnerNorApproved();

// buy
error InconsistentSalePrice();
error InconsistentTokens();
error InvalidListing();
error IncorrectValueSent();
error InsufficientAllowance();

/// @title No Intermediary NFT Trading Protocol with Value-added Royalty
/// @dev The royalty scheme used by this reference implementation is Value-Added Royalty
contract ERC6105 is ERC721, ERC2981, IERC6105, ReentrancyGuard{

  /// @dev A structure representing a listed token
  ///      The zero `salePrice` indicates that the token is not for sale
  ///      The zero `expires` indicates that the token is not for sale
  /// @param salePrice - the price the token is being sold for
  /// @param expires - UNIX timestamp, the buyer could buy the token before expires
  /// @param supportedToken - contract addresses of supported ERC20 token or zero address
  ///                         The zero address indicates that the supported token is ETH
  ///                         Buyer needs to purchase item with supported token
  /// @param historicalPrice - The price at which the seller last bought this token
  struct Listing {
    uint256 salePrice;
    uint64 expires;
    address supportedToken;
    uint256 historicalPrice;
  }

  // Mapping from token Id to listing index
  mapping(uint256 => Listing) private _listings;

  constructor()
    ERC721("TOKEN", "SYMBOL")
    {
    }

  /// @notice Create or update a listing for `tokenId`
  /// @dev `salePrice` MUST NOT be set to zero
  /// @param tokenId - identifier of the token being listed
  /// @param salePrice - the price the token is being sold for
  /// @param expires - UNIX timestamp, the buyer could buy the token before expires
  /// @param supportedToken - contract addresses of supported ERC20 token or zero address
  ///                         The zero address indicates that the supported token is ETH
  ///                         Buyer needs to purchase item with supported token
  function listItem (
    uint256 tokenId,
    uint256 salePrice,
    uint64 expires,
    address supportedToken
    ) external virtual{
        listItem(tokenId, salePrice, expires, supportedToken, 0);
    }

  /// @notice Create or update a listing for `tokenId` with `historicalPrice`
  /// @dev `price` MUST NOT be set to zero
  /// @param tokenId - identifier of the token being listed
  /// @param salePrice - the price the token is being sold for
  /// @param expires - UNIX timestamp, the buyer could buy the token before expires
  /// @param supportedToken - contract addresses of supported ERC20 token or zero address
  ///                         The zero address indicates that the supported token is ETH
  ///                         Buyer needs to purchase item with supported token
  /// @param historicalPrice - The price at which the seller last bought this token
  function listItem (
    uint256 tokenId,
    uint256 salePrice,
    uint64 expires,
    address supportedToken,
    uint256 historicalPrice
    ) public virtual{
    address tokenOwner = ownerOf(tokenId);
    if(salePrice <= 0) {
        revert SalePriceCannotBeZero();
    }
    if(expires < block.timestamp) {
        revert InvalidExpiresTimestamp();
    }
    if(!_isApprovedOrOwner(msg.sender, tokenId)) {
        revert CallerIsntOwnerNorApproved();
    }
    _listings[tokenId] = Listing(salePrice, expires, supportedToken, historicalPrice);
    emit UpdateListing(tokenId, tokenOwner, salePrice, expires, supportedToken, historicalPrice);
  }

  /// @notice Remove the listing for `tokenId`
  /// @param tokenId - identifier of the token being listed
  function delistItem(uint256 tokenId) external virtual{
    require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC6105: caller is not owner nor approved");
    require(_isForSale(tokenId), "ERC6105: invalid listing" );

    _removeListing(tokenId);
  }

  /// @notice Buy a token and transfers it to the caller
  /// @dev `salePrice` and `supportedToken` must match the expected purchase price and token to prevent front-running attacks
  /// @param tokenId - identifier of the token being purchased
  /// @param salePrice - the price the token is being sold for
  /// @param supportedToken - contract addresses of supported token or zero address
  function buyItem(uint256 tokenId, uint256 salePrice, address supportedToken) external nonReentrant payable virtual{
    address tokenOwner = ownerOf(tokenId);
    address buyer = msg.sender;
    uint256 historicalPrice = _listings[tokenId].historicalPrice;

    if(salePrice != _listings[tokenId].salePrice) {
        revert InconsistentSalePrice();
    }
    if(supportedToken != _listings[tokenId].supportedToken) {
        revert InconsistentTokens();
    }
    if(!_isForSale(tokenId)) {
        revert InvalidListing();
    }

    /// @dev Handle royalties
    (address royaltyRecipient, uint256 royalties) = _calculateRoyalties(tokenId, salePrice, historicalPrice);

    uint256 payment = salePrice - royalties;
    if(supportedToken == address(0)){
        if(msg.value != salePrice) {
           revert IncorrectValueSent();
        }
        _processSupportedTokenPayment(royalties, buyer, royaltyRecipient, address(0));
        _processSupportedTokenPayment(payment, buyer, tokenOwner, address(0));
    }
    else{
        uint256 num = IERC20(supportedToken).allowance(buyer, address(this));
        if(num < salePrice) {
            revert InsufficientAllowance();
        }
        _processSupportedTokenPayment(royalties, buyer, royaltyRecipient, supportedToken);
        _processSupportedTokenPayment(payment, buyer, tokenOwner, supportedToken);
    }
    _transfer(tokenOwner, buyer, tokenId);
    emit Purchased(tokenId, tokenOwner, buyer, salePrice, supportedToken, royalties);
  }

  /// @notice Return the listing for `tokenId`
  /// @dev The zero sale price indicates that the token is not for sale
  ///      The zero expires indicates that the token is not for sale
  ///      The zero supported token address indicates that the supported token is ETH
  /// @param tokenId identifier of the token being queried
  /// @return the specified listing (sale price, expires, supported token, benchmark price)
  function getListing(uint256 tokenId) external view virtual returns (uint256, uint64, address, uint256) {
    if(_listings[tokenId].salePrice > 0 && _listings[tokenId].expires >=  block.timestamp){
    uint256 salePrice = _listings[tokenId].salePrice;
    uint64 expires = _listings[tokenId].expires;
    address supportedToken =  _listings[tokenId].supportedToken;
    uint256 historicalPrice = _listings[tokenId].historicalPrice;
    return (salePrice, expires, supportedToken, historicalPrice);
    }
    else{
      return (0, 0, address(0), 0);
    }
  }

  /// @dev Remove the listing for `tokenId`
  /// @param tokenId - identifier of the token being delisted
  function _removeListing(uint256 tokenId) internal virtual{
    address tokenOwner = ownerOf(tokenId);
    delete _listings[tokenId];
    emit UpdateListing(tokenId, tokenOwner, 0, 0, address(0), 0);
  }

  /// @dev Check if the token is for sale
  function _isForSale(uint256 tokenId) internal virtual returns(bool){
    if(_listings[tokenId].salePrice > 0 && _listings[tokenId].expires >= block.timestamp){
        return true;
    }
    else{
        return false;
    }    
  }
  
  /// @dev Handle Value Added Royalty
  function _calculateRoyalties(
    uint256 tokenId,
    uint256 price,
    uint256 historicalPrice
    ) internal virtual returns(address, uint256){
    uint256 taxablePrice;
    if(price > historicalPrice){
      taxablePrice = price - historicalPrice;
    }
    else{
      taxablePrice = 0 ;
    }

    (address royaltyRecipient, uint256 royalties) = royaltyInfo(tokenId, taxablePrice);
    return(royaltyRecipient, royalties);
  }

  /// @dev Process a `supportedToken` of `amount` payment to `recipient`.
  /// @param amount - the amount to send
  /// @param from - the payment payer
  /// @param recipient - the payment recipient
  /// @param supportedToken - contract addresses of supported ERC20 token or zero address
  ///                         The zero address indicates that the supported token is ETH
  function _processSupportedTokenPayment(
    uint256 amount,
    address from,
    address recipient,
    address supportedToken
    ) internal virtual{
    if(supportedToken == address(0))
    {
      (bool success,) = payable(recipient).call{value: amount}("");
      require(success, "Ether Transfer Fail"); 
    }
    else{
    (bool success) = IERC20(supportedToken).transferFrom(from, recipient, amount);
    require(success, "Supported Token Transfer Fail");
    }
  }
  
  /// @dev See {IERC165-supportsInterface}.
  function supportsInterface(bytes4 interfaceId) public view virtual override (ERC721, ERC2981) returns (bool) {
     return interfaceId == type(IERC6105).interfaceId || super.supportsInterface(interfaceId);
  }

  /// @dev Before transferring the NFT, need to delete listing
  function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) internal virtual override{
      super._beforeTokenTransfer(from, to, tokenId, batchSize);
      if(_isForSale(tokenId)){
          _removeListing(tokenId);
      }
  }
}




