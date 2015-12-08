var Matrix = React.createClass({
  render: function() {
    var cells = [];
    for (var i = 1; i < 10; i++) {
      cells.push(
        <Cell 
          key={i} 
          index={i}
          onClick={this.props.onClick}
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
