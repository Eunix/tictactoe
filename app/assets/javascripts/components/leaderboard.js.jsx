var Leaderboard = React.createClass({

  render: function() {
    var playerRows = this.props.playersData.map(function(player) {
      return (
        <tr key={player.id}>
          <td>{player.name}</td>
          <td>{player.score}</td>
        </tr>
      );
    });

    return (
      <table>
        <thead>
          <tr>
            <th>Player</th>
            <th>Score</th>
          </tr>
        </thead>
        <tbody>
          {playerRows}
        </tbody>
      </table>
    )
  },
});
