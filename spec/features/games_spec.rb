require 'spec_helper'

feature 'Games' do
  given!(:game) { Fabricate(:game) }
  given!(:player1) { Fabricate(:player, name: 'Terra') }
  given!(:player2) { Fabricate(:player, name: 'Locke') }
  given!(:player3) { Fabricate(:player, name: 'Celes') }
  given!(:player4) { Fabricate(:player, name: 'Sabin') }

  before do 
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:default]
  end

  # TODO: factor out these form steps into a module
  scenario 'creating a new team game', js: true do
    visit games_path
    click_link 'New game'
    select 'Terra', from: 'game_red_offense_id'
    select 'Locke', from: 'game_red_defense_id'
    # capybara appears to be unable to manipulate html5 sliders, so set them directly with jquery instead
    # TODO: find a better way to do this or at least abstract it out
    page.execute_script("$('#game_red_score').val('10')")
    select 'Celes', from: 'game_blue_offense_id'
    select 'Sabin', from: 'game_blue_defense_id'
    page.execute_script("$('#game_blue_score').val('5')")
    click_button 'Submit'
    expect(page).to have_content 'Terra'
    expect(page).to have_content 'Sabin'
    expect(page).to have_content '10'
    expect(page).to have_content '5'
  end

  # TODO: factor out these form steps into a module
  scenario 'creating a new solo game', js: true do
    visit games_path
    click_link 'New game'
    check 'Solo'
    select 'Terra', from: 'game_red_offense_id'
    page.execute_script("$('#game_red_score').val('8')")
    select 'Celes', from: 'game_blue_offense_id'
    page.execute_script("$('#game_blue_score').val('2')")
    click_button 'Submit'
    expect(page).to have_content 'Terra'
    expect(page).to have_content 'Celes'
    expect(page).to have_content '8'
    expect(page).to have_content '2'
  end

  scenario 'deleting a game' do
    visit game_path(game)
    click_link 'Delete'
    expect(page).to_not have_content 'Show'
  end

  given!(:player) { Fabricate(:player, name: 'Edgar') }
  scenario 'editing a game' do
    visit game_path(game)
    click_link 'Edit'
    select 'Edgar', from: 'game_blue_defense_id'
    click_button 'Submit'
    expect(page).to have_content 'Edgar'
  end
end