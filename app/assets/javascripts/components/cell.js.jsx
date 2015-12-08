var Cell = React.createClass({
  getInitialState: function() {
    return { symbol: null };
  },
  
  render: function() {
    return (
      <div 
        className={this.classes()}
        onMouseUp={this.clickHandler}
      />
    )
  },

  clickHandler: function() {
    if (!this.state.symbol) {
      this.setState({
        symbol: 'x'
      });
      //gameState.updateState(this.props.index);
      return this.props.onClick();
    }
  },
   
  classes: function() {
    return ['cell', this.state.symbol ? this.state.symbol + "Symbol" : ''].join(' ');
  }
      
  //clickHandler: ->
    //if !@state.symbol
      //@setState symbol: gameState.currentSymbol()
      //gameState.updateState(@props.index)
      //@props.onClick()
});
