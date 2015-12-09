var TicTacToe = React.createClass({
  getInitialState: function() {
    return { playersData: [] };
  },

  // Loads leaderboard from server
  loadPlayersFromServer: function() {
    $.ajax({
      url: '/players',
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({ playersData: data });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(status, err.toString());
      }.bind(this)
    });
  },

  componentDidMount: function() {
    this.loadPlayersFromServer();
  },

  render: function() {
    return (
      <div className="ticTacToe row">
        <div className="medium-6 columns">
          <GameField 
            onGameFinish={this.handleGameFinish}
          />
        </div>
        <div className="medium-6 columns">
          <Leaderboard 
            playersData={this.state.playersData}
          />
        </div>
      </div>
    )
  },

  // Handles game finish to load last leaders
  handleGameFinish: function() {
    this.loadPlayersFromServer();
  }
});
