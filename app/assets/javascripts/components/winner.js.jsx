var Winner = React.createClass({

  render: function() {
    var info;
    if(this.props.gameWinnerName === null || this.props.gameWinnerName === '') {
      info = <span>Nobody wins</span>;
    } else {
      info = <span>The winner is <strong>{this.props.gameWinnerName}</strong></span>
    }

    return (
      <div className={this.classes()}>
        {info}    
        <br/>
        <a onClick={this.props.onRestartButtonClick} className="button tiny">
          Restart Game
        </a>
      </div>
    )
  },

  classes: function() {
    return ['winner', this.props.gameState == 'finished' ? '' : 'hidden'].join(' ');
  }
});
