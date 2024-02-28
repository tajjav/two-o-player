class Game
  def initialize(player1, player2)
    @players = [player1, player2]
    @current_index = 0
  end

  def next_player
    @current_index = (@current_index + 1) % @players.size
    @players[@current_index]
  end

  def play
    while @players.all?(&:alive?)
      current_player = @players[@current_index]
      question = Question.new
      question.ask_question(current_player.name)
      answer = gets.chomp.to_i
      if question.correct_answer?(answer)
        puts "YES! You are correct."
      else
        current_player.lose_life
        puts "Seriously? No!"
      end
      show_scores
      next_player
    end
    game_over
  end

  def show_scores
    @players.each do |player|
      puts "#{player.name}: #{player.lives}/3"
    end
  end

  def game_over
    winner = @players.find(&:alive?)
    puts "#{winner.name} wins with a score of #{winner.lives}/3"
    puts "----- GAME OVER -----"
    puts "Good bye!"
  end
end