#! /usr/bin/env ruby
module RockPaperScissors
  MOVES = {
    "r" => {
      "name" => "rock",
      "beats" => "s"
    },
    "p" => {
      "name" => "paper",
      "beats" => "r"
    },
    "s" => {
      "name" => "scissors",
      "beats" => "p"
    },
  }

  MOVE_KEYS = MOVES.keys

  module_function

  def _prompt(text)
    puts text
    print "> "
    gets.chomp
  end

  def prompt(text)
    if block_given?
      loop do
        answer = _prompt(text)
        break answer if yield(answer)
      end
    else
      _prompt(text)
    end
  end

  def play
    loop do
      player_move = prompt("Rock, paper, or scissors? (r/p/s)") do |answer|
        break answer if MOVE_KEYS.include?(answer)
        puts "You must enter r, p, or s"
      end

      puts "You played #{MOVES[player_move]["name"]}"

      computer_move = MOVE_KEYS.shuffle.first

      puts "Computer played #{MOVES[computer_move]["name"]}"

      if MOVES[player_move]["beats"] == computer_move
        puts "You win!"
      elsif player_move == computer_move
        puts "Tie!"
      else
        puts "You lose!"
      end

      unless prompt("Would you like to play again? (y/n)").start_with?("y")
        puts "Bye!"
        break
      end
    end
  end
end

RockPaperScissors.play
