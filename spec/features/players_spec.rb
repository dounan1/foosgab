require 'spec_helper'

feature 'Players' do
  given!(:player) { Fabricate(:player, name: 'Barry') }

  scenario 'creating a new player' do
    visit players_path
    click_link 'New Player'
    fill_in 'Name', with: 'Capy'
    click_button 'Submit'
    expect(page).to have_content 'Capy'
  end

  scenario 'deleting a player' do
    visit player_path(player)
    expect(page).to have_content 'Barry'
    click_link 'Delete'
    expect(page).to_not have_content 'Barry'
  end

  scenario 'editing a player' do
    visit player_path(player)
    expect(page).to have_content 'Barry'
    click_link 'Edit'
    fill_in 'Name', with: 'Foosy'
    click_button 'Submit'
    expect(page).to have_content 'Foosy'
  end
end