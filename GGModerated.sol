/**
 * @title Moderated
 * Moderator can make transfers from and to any account (including frozen).
 */
contract GGModerated is GGOwnable {

  address public moderator;
  address public newModerator;

  /**
   * Throws if called by any account other than the moderator.
   */
  modifier onlyModerator() {
    require(msg.sender == moderator);
    _;
  }

  /**
   * Throws if called by any account other than the owner or moderator.
   */
  modifier onlyOwnerOrModerator() {
    require((msg.sender == moderator) || (msg.sender == owner));
    _;
  }

  /**
   * Moderator same as owner
   */
  function GGModerated(){
    moderator = msg.sender;
  }

  /**
   * Allows the current moderator to transfer control of the contract to an otherModerator.
   */
  function transferModeratorship(address otherModerator) onlyModerator {
    newModerator = otherModerator;
  }

  /**
   * Complete moderatorship transfer.
   */
  function approveModeratorship() {
    require(msg.sender == newModerator);
    moderator = newModerator;
    newModerator = address(0);
  }

  /**
   * Removes moderator from the contract.
   */
  function removeModeratorship() onlyOwner {
      moderator = address(0);
  }

  function hasModerator() constant returns(bool) {
      return (moderator != address(0));
  }
}
