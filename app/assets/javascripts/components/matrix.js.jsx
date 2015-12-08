var Matrix = React.createClass({
  render: function() {
    var cells = [];
    for (var i = 1; i < 10; i++) {
      cells.push(
        <Cell 
          key={i} 
          position={i}
          gameId={this.props.gameId}
        />
      );
    }

    return (
      <div className={this.classes()}>
        {cells}
      </div>
    );
  },

  classes: function() {
    return ['matrix', this.props.gameIsStarted ? '' : 'hidden'].join(' ');
  }
});
