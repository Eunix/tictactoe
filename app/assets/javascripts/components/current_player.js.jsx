var CurrentPlayer = React.createClass({

  render: function() {
    return (
      <div className={this.classes()}>
        {this.props.gameCurrentPlayer}'s move
      </div>
    )
  },

  // Hides current player's move before game is started
  classes: function() {
    return ['currentPlayer', this.props.gameIsStarted ? '' : 'hidden'].join(' ');
  }
});
