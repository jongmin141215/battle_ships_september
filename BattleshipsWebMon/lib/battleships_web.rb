require 'sinatra/base'
require_relative '../game_setup'

class BattleshipsWeb < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index
  end

  get '/newGame' do
    erb :newGame
  end

  get '/greetings' do
    @visitor = params[:name]
    $board = Board.new(Cell)
    $computer_board = Board.new(Cell)
    erb :greetings
  end

  get '/vs_computer' do
    @destroyer = Ship.destroyer
    coordinates_1 = params[:coordinates_1].to_sym if params[:coordinates_1]
    orientation_1 = params[:orientation_1].to_sym if params[:orientation_1]
      if coordinates_1 && orientation_1
        $board.place(@destroyer, coordinates_1, orientation_1)
      end
    @battleship = Ship.battleship
    coordinates_2 = params[:coordinates_2].to_sym if params[:coordinates_2]
    orientation_2 = params[:orientation_2].to_sym if params[:orientation_2]
      if coordinates_2 && orientation_2
        $board.place(@battleship, coordinates_2, orientation_2)
      end
    @aircraft_carrier = Ship.aircraft_carrier
    coordinates_3 = params[:coordinates_3].to_sym if params[:coordinates_3]
    orientation_3 = params[:orientation_3].to_sym if params[:orientation_3]
      if coordinates_3 && orientation_3
        $board.place(@aircraft_carrier, coordinates_3, orientation_3)
      end
    @patrol_boat = Ship.patrol_boat
    coordinates_4 = params[:coordinates_4].to_sym if params[:coordinates_4]
    orientation_4 = params[:orientation_4].to_sym if params[:orientation_4]
      if coordinates_4 && orientation_4
        $board.place(@patrol_boat, coordinates_4, orientation_4)
      end
    @submarine = Ship.submarine
    coordinates_5 = params[:coordinates_5].to_sym if params[:coordinates_5]
    orientation_5 = params[:orientation_5].to_sym if params[:orientation_5]
      if coordinates_5 && orientation_5
        $board.place(@submarine, coordinates_5, orientation_5)
      end
    if $computer_board.ships.size == 0
      $computer_board.place_ship_randomly(2)
      $computer_board.place_ship_randomly(3)
      $computer_board.place_ship_randomly(3)
      $computer_board.place_ship_randomly(4)
      $computer_board.place_ship_randomly(5)
    end
    @fire = params[:fire].to_sym if params[:fire]
    $computer_board.shoot_at(@fire) if @fire

    if $board.ships.size >= 5
      $board.fire_randomly
    end
    erb :vs_computer
  end

  get '/game_board' do
    @destroyer = Ship.destroyer
    coordinates_1 = params[:coordinates_1].to_sym if params[:coordinates_1]
    orientation_1 = params[:orientation_1].to_sym if params[:orientation_1]
      if coordinates_1 && orientation_1
        $board.place(@destroyer, coordinates_1, orientation_1)
      end
    @battleship = Ship.battleship
    coordinates_2 = params[:coordinates_2].to_sym if params[:coordinates_2]
    orientation_2 = params[:orientation_2].to_sym if params[:orientation_2]
      if coordinates_2 && orientation_2
        $board.place(@battleship, coordinates_2, orientation_2)
      end
    @aircraft_carrier = Ship.aircraft_carrier
    coordinates_3 = params[:coordinates_3].to_sym if params[:coordinates_3]
    orientation_3 = params[:orientation_3].to_sym if params[:orientation_3]
      if coordinates_3 && orientation_3
        $board.place(@aircraft_carrier, coordinates_3, orientation_3)
      end
    @patrol_boat = Ship.patrol_boat
    coordinates_4 = params[:coordinates_4].to_sym if params[:coordinates_4]
    orientation_4 = params[:orientation_4].to_sym if params[:orientation_4]
      if coordinates_4 && orientation_4
        $board.place(@patrol_boat, coordinates_4, orientation_4)
      end
    @submarine = Ship.submarine
    coordinates_5 = params[:coordinates_5].to_sym if params[:coordinates_5]
    orientation_5 = params[:orientation_5].to_sym if params[:orientation_5]
      if coordinates_5 && orientation_5
        $board.place(@submarine, coordinates_5, orientation_5)
      end
    @fire = params[:fire].to_sym if params[:fire]
    $board.shoot_at(@fire) if @fire
    erb :game_board
  end

set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0
end
