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
      click_button('Start new game')
      expect(page).to have_content("Player1's move")
    end

    scenario 'User can win a game', js: true do
      fill_in('playerX', with: 'Player1')
      fill_in('playerO', with: 'Player2')
      click_button('Start new game')
      find('.cell-1').trigger(:mouseup)
      find('.cell-2').trigger(:mouseup)
      find('.cell-5').trigger(:mouseup)
      find('.cell-3').trigger(:mouseup)
      find('.cell-9').trigger(:mouseup)
      expect(page).to have_content('The winner is Player1')
    end
  end
end
