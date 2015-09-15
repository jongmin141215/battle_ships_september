require 'sinatra/base'
require_relative '../game_setup'

class BattleshipsWeb < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/newGame' do
    erb :newGame
  end

  get '/greetings' do
    @visitor = params[:name]
    erb :greetings
  end

  get '/game_board' do
    @board = Board.new(Cell).print_board
    erb :game_board
  end

set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0
end
