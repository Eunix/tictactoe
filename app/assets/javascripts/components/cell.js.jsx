var Cell = React.createClass({
  getInitialState: function() {
    return { symbol: null };
  },
  
  render: function() {
    return (
      <div 
        className={this.classes()}
        onMouseUp={this.handleCellClick}
      />
    )
  },

  handleCellClick: function() {
    if (!this.state.symbol) {
      $.ajax({
        url: '/games/' + this.props.gameId + '/next_move',
        dataType: 'json',
        type: 'PUT',
        data: { position: this.props.position },
        success: function(data) {
          this.setState({ symbol: data.symbol });
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(status, err.toString());
        }.bind(this)
      });
      //this.props.onCellClick(this.props.position);
    }
  },
   
  classes: function() {
    return ['cell', this.state.symbol ? this.state.symbol + "Symbol" : ''].join(' ');
  }
});
