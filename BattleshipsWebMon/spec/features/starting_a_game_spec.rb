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

  scenario 'pressing start game button takes me to board' do 
    visit '/greetings'
    click_link("Start Game")
    expect(page).to have_content "Game Board"
  end

end
