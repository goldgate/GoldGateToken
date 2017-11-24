/**
 * @title Pausable
 */
contract GGPausable is Pausable, GGModerated {
  /**
   * called by the owner or moderator to pause, triggers stopped state
   */
  function pause() onlyOwnerOrModerator whenNotPaused {
    paused = true;
    Pause();
  }

  /**
   * called by the owner or moderator to unpause, returns to normal state
   */
  function unpause() onlyOwnerOrModerator whenPaused {
    paused = false;
    Unpause();
  }
}
