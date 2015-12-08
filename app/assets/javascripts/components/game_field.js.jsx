var GameField = React.createClass({
  getInitialState: function() {
    return {
      gameIsStarted: false,
      gameId: null,
      gameState: 'new',
      gameWinnerName: '',
      playerX: '',
      playerO: '',
      gameCurrentPlayer: ''
    };
  },

  render: function() {
    return (
      <div className="field">
        <CurrentPlayer 
          gameCurrentPlayer={this.state.gameCurrentPlayer}
          gameIsStarted={this.state.gameIsStarted}
        />
        <Matrix 
          onCellClick={this.handleCellClick}
          gameIsStarted={this.state.gameIsStarted}
          gameId={this.state.gameId}
        />
        <PlayersForm 
          onPlayersFormSubmit={this.handlePlayersFormSubmit}
          gameIsStarted={this.state.gameIsStarted}
          gameState={this.state.gameState}
        />
        <Winner
          gameState={this.state.gameState}
          gameWinnerName={this.state.gameWinnerName}
          onRestartButtonClick={this.handleRestartButtonClick}
        />
      </div>
    );
  },

  createNewGame: function() {
    var players = {
      player_x_name: this.state.playerX,
      player_o_name: this.state.playerO
    }

    $.ajax({
      url: '/games',
      dataType: 'json',
      type: 'POST',
      data: { game: players },
      success: function(data) {
        this.setState({ 
          gameIsStarted: true,
          gameId: data.id,
          gameCurrentPlayer: this.state.playerX
        }); 
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(status, err.toString());
      }.bind(this)
    });
  },

  handlePlayersFormSubmit: function(players) {
    this.setState({
      playerX: players.playerX,
      playerO: players.playerO
    },
    function() {
      this.createNewGame();
    });
  },

  handleCellClick: function(data) {
    if(data.state == 'finished') {
      this.setState({
        gameState: data.state, 
        gameWinnerName: data.winner_name, 
        gameIsStarted: false
      });
      
      this.props.onGameFinish();
    }

    if(this.state.gameCurrentPlayer === this.state.playerO) {
      this.setState({ gameCurrentPlayer: this.state.playerX });
    } else {
      this.setState({ gameCurrentPlayer: this.state.playerO });
    }
  },

  handleRestartButtonClick: function() {
    this.setState({
      gameState: 'new', 
      gameWinnerName: null, 
      gameIsStarted: true,
      playerX: this.state.playerO,
      playerO: this.state.playerX,
      gameCurrentPlayer: this.state.playerO
    },
    function() {
      this.createNewGame();
    });
  }
});
