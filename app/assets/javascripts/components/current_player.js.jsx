var CurrentPlayer = React.createClass({

  render: function() {
    return (
      <div className={this.classes()}>
        {this.props.gameCurrentPlayer}'s move
      </div>
    )
  },

  classes: function() {
    return ['currentPlayer', this.props.gameIsStarted ? '' : 'hidden'].join(' ');
  }
});
