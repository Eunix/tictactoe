var GameField = React.createClass({
  getInitialState: function() {
    return {
      gameIsStarted: false
    };
  },

  render: function() {
    return (
      <div className="field">
        <Matrix 
          onClick={this.onCellClick}
          gameIsStarted={this.state.gameIsStarted}
        />
        <PlayersForm 
          onPlayersFormSubmit={this.handlePlayersFormSubmit}
          gameIsStarted={this.state.gameIsStarted}
        />
      </div>
    );
  },

  handlePlayersFormSubmit: function(players) {
    this.setState({gameIsStarted: true}); 
    //$.post(
      //'/games',
      //{ players: this.state },
      //function(data) {
      //},
      //'JSON'
    //);
  },

  onNewGame: function() {
    //gameState.reset();
    return this.setState({
      gameIsBeingPlayed: true
    });
  },

  onCellClick: function() {
    alert('wer');
    //if (gameState.winner) {
      //return this.setState({
        //gameIsBeingPlayed: false
      //});
    //}
  }
  //onNewGame: ->
    //gameState.reset()
    //@setState gameIsBeingPlayed: true

  //onCellClick: ->
    //if gameState.winner
      //@setState gameIsBeingPlayed: false
});
