# TicTacToe

[![Build Status](https://travis-ci.org/Eunix/tictactoe.svg?branch=master)](https://travis-ci.org/Eunix/tictactoe)

A [TicTacToe](https://en.wikipedia.org/wiki/Tic-tac-toe) game using ReactJS and Rails

## A little bit of math

I use a matrix of powers of two to determine a winner:

```
  1   2   4
  8   16  32
  64  128 256
```

If the [Bitwise-AND](https://en.wikipedia.org/wiki/Bitwise_operation#AND) of any special winner numbers and
players sum is the winner number then this player is the winner of the game.

A special winner number is just a sum of horizontal, vertical, or diagonal rows — the condition to win TicTacToe
game.

## Page structure (react components)

```
- TicTacToe
  - GameField
    - CurrentPlayer
    - Matrix
      - Cells
    - PlayersForm
    - Winner
  - Leaderbord
```

## Development tools

### Server

```sh
bin/rails s
```

### Tests

```sh
bin/rspec
```

