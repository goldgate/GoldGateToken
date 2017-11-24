/**
 * @title Ownable
 */
contract GGOwnable is Ownable {

  address public newOwner;

  /**
   * Allows the current owner to transfer control of the contract to an otherOwner.
   */
  function transferOwnership(address otherOwner) onlyOwner {
    require(otherOwner != address(0));      
    newOwner = otherOwner;
  }

  /**
   * Finish ownership transfer.
   */
  function approveOwnership() {
    require(msg.sender == newOwner);
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
    newOwner = address(0);
  }
}
