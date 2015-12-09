require 'rails_helper'

feature 'Game' do
  before { visit '/' }

  context 'filling players form' do
    scenario 'User inputs no names', js: true do
      expect(page).to have_button('Start new game', disabled: true)
    end

    scenario 'User inputs same names', js: true do
      fill_in('playerX', with: 'Player')
      fill_in('playerO', with: 'Player')
      expect(page).to have_button('Start new game', disabled: true)
    end

    scenario 'User inputs correct names', js: true do
      fill_in('playerX', with: 'Player1')
      fill_in('playerO', with: 'Player2')
      expect(page).to have_button('Start new game', disabled: false)
    end
  end

  context 'playing game' do
    scenario 'User starts to play new round', js: true do
      fill_in('playerX', with: 'Player1')
      fill_in('playerO', with: 'Player2')
      find_button('Start new game').trigger('click')
      expect(page).to have_content("Player1's move")
    end
  end
end
