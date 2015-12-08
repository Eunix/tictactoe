var GameField = React.createClass({
  getInitialState: function() {
    return {
      gameIsStarted: false,
      gameId: null 
    };
  },

  render: function() {
    return (
      <div className="field">
        <Matrix 
          onCellClick={this.handleCellClick}
          gameIsStarted={this.state.gameIsStarted}
          gameId={this.state.gameId}
        />
        <PlayersForm 
          onPlayersFormSubmit={this.handlePlayersFormSubmit}
          gameIsStarted={this.state.gameIsStarted}
        />
      </div>
    );
  },

  handlePlayersFormSubmit: function(players) {
    $.ajax({
      url: '/games',
      dataType: 'json',
      type: 'POST',
      data: { game: players },
      success: function(data) {
        this.setState({ 
          gameIsStarted: true,
          gameId: data.id
        }); 
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(status, err.toString());
      }.bind(this)
    });
  },
});
