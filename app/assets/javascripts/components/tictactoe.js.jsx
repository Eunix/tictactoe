var TicTacToe = React.createClass({
  getInitialState: function() {
    return { playersData: [] };
  },

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

  handleGameFinish: function() {
    this.loadPlayersFromServer();
  }
});
