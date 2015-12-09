var Cell = React.createClass({
  getInitialState: function() {
    return { symbol: null };
  },
  
  componentWillReceiveProps: function() {
    if(this.props.gameIsStarted === false) {
      this.setState({ symbol: null });
    }
  },

  render: function() {
    return (
      <div 
        className={this.classes()}
        onMouseUp={this.handleCellClick}
      />
    )
  },

  // Handles click on cell and send request to perform next move
  handleCellClick: function() {
    if (!this.state.symbol) {
      $.ajax({
        url: '/games/' + this.props.gameId + '/next_move',
        dataType: 'json',
        type: 'PUT',
        data: { position: this.props.position },
        success: function(data) {
          this.setState({ symbol: data.symbol });
          this.props.onCellClick(data);
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(status, err.toString());
        }.bind(this)
      });
    }
  },
   
  // xSymbol and oSymbol classes are for display x and o correspondingly 
  classes: function() {
    return [
      'cell', 
      'cell-' + this.props.position,
      this.state.symbol ? this.state.symbol + "Symbol" : ''
    ].join(' ');
  }
});
