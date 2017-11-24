/**
 * Pausable token with moderator role and freeze address implementation
 **/
contract ModToken is StandardToken, GGPausable {

  mapping(address => bool) frozen;

  /**
   * check if given address is frozen. Freeze works only if moderator role is active
   */
  function isFrozen(address _addr) constant returns (bool){
      return frozen[_addr] && hasModerator();
  }

  /**
   * Freezes address (no transfer can be made from or to this address).
   */
  function freeze(address _addr) onlyModerator {
      frozen[_addr] = true;
  }

  /**
   * Unfreezes frozen address.
   */
  function unfreeze(address _addr) onlyModerator {
      frozen[_addr] = false;
  }

  /**
   * Declines transfers from/to frozen addresses.
   */
  function transfer(address _to, uint256 _value) whenNotPaused returns (bool) {
    require(!isFrozen(msg.sender));
    require(!isFrozen(_to));
    return super.transfer(_to, _value);
  }

  /**
   * Declines transfers from/to/by frozen addresses.
   */
  function transferFrom(address _from, address _to, uint256 _value) whenNotPaused returns (bool) {
    require(!isFrozen(msg.sender));
    require(!isFrozen(_from));
    require(!isFrozen(_to));
    return super.transferFrom(_from, _to, _value);
  }

  /**
   * Allows moderator to transfer tokens from one address to another.
   */
  function moderatorTransferFrom(address _from, address _to, uint256 _value) onlyModerator returns (bool) {
    balances[_to] = balances[_to].add(_value);
    balances[_from] = balances[_from].sub(_value);
    Transfer(_from, _to, _value);
    return true;
  }
}
