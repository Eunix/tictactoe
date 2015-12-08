var PlayersForm = React.createClass({
  getInitialState: function() {
    return { playerX: '', playerO: '' };
  },

  handleChange: function(e) {
    var state = {};
    state[e.target.name] = e.target.value;
    this.setState(state);
  },

  handleSubmit: function(e) {
    e.preventDefault();
    var playerX = this.state.playerX.trim();
    var playerO = this.state.playerO.trim();
    this.props.onPlayersFormSubmit({
      player_x_name: playerX,
      player_o_name: playerO
    });
  },

  valid: function() {
    return (this.state.playerX && this.state.playerO);
  },

  render: function() {
    return (
      <form className={this.classes()} onSubmit={this.handleSubmit}>
        <input 
          type="text" 
          name="playerX"
          placeholder="Name of Player 1" 
          value={this.state.playerX}
          onChange={this.handleChange}
        />
        <input 
          type="text" 
          name="playerO"
          placeholder="Name of Player 2" 
          value={this.state.playerO}
          onChange={this.handleChange}
        />
        <input 
          type="submit" 
          value="Start new game" 
          className="button tiny"
          disabled={!this.valid()}
        />
      </form>
    )
  },

  classes: function() {
    return ['playersForm', this.props.gameIsStarted ? 'hidden' : ''].join(' ');
  }
});
