require 'spec_helper'

feature 'Starting a new game' do
  scenario 'I am asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'entering my name takes me to a new page containing a greeting' do
    visit '/newGame'
    fill_in('name', :with => 'Archie')
    click_button('Submit')
    expect(page).to have_content "Greetings Archie!"
  end

  scenario 'not entering a name will ask for a name' do
    visit '/newGame'
    fill_in('name', :with => '')
    click_button('Submit')
    expect(page).to have_content "Please enter a name!"
  end
  scenario 'pressing submit button shows two options' do
    visit '/greetings?name=Jongmin'
    expect(page).to have_content "Start Game"
    expect(page).to have_content "Play with Computer"
  end

  scenario 'pressing play with computer takes me to a game with computer' do
    visit '/greetings'
    click_link 'Play with Computer'
    expect(page).to have_content "A B C D E F G H I J"
  end

  scenario '' do
    visit '/greetings'
    click_link 'Play with Computer'
    expect(page).to have_content "A B C D E F G H I J"
  end

  # scenario 'pressing start game button takes me to board' do
  #   visit '/greetings'
  #   click_link("Start Game")
  #   expect(page).to have_content "A"
  # end



  # scenario 'can add ships to the board' do
  #   visit '/game_board?coordinates_1=A1&orientation_1=horizontally'
  #   # fill_in('coordinates_1', :with => 'A1')
  #   # within("#destoyer_radio") do
  #   # choose('Horizontally')
  #     # click_button("Place")
  #   # end
  #   expect(page).to have_css("#ffff32")
  # end

end
