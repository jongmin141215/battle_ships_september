require 'sinatra/base'
require_relative '../game_setup'

class BattleshipsWeb < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views') }
  enable :sessions

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

  get '/board' do
    $board ||= Board.new(Cell)
    $computer_board ||= Board.new(Cell)
    $opponent_board ||= Board.new(Cell)
    erb :board
  end

  post '/place_ship' do
    $i ||= 1    # need to fix
    if $i <= 5
      $board.place(Ship.new($i), params[:coordinates].to_sym, params[:orientation].to_sym)
      $i += 1
      redirect to('/board')
    end
    redirect to('/computer_place_ship')
  end

  get '/computer_place_ship' do
    if $computer_board.ships.size == 0
      5.times { |i| $computer_board.place_ship_randomly(i + 1) }
    end
    redirect to('/vs_computer')
  end

  post '/fire' do
    @fire = params[:fire].to_sym if params[:fire]
    $computer_board.shoot_at(@fire) if @fire
    redirect to '/computer_fire'
  end

  get '/computer_fire' do
    if $board.ships.size == 5
      $board.fire_randomly
    end
    redirect to('/vs_computer')
  end

  get '/vs_computer' do
    erb :vs_computer
  end

  get '/game_board' do

    erb :game_board
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
