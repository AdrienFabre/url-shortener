require 'spec_helper'

feature 'shorten url' do
  scenario ' user can see the homepage with instructions' do
    visit '/'
    expect(page).to have_content 'Paste your URL!'
  end

  scenario 'user can paste an url an receive a result' do
    visit '/'
    fill_in 'urlBox', with: 'http://adrienfabre.dev'
    click_button('Shorten')
    expect(page).to have_content 'http://adrienfabre.dev'
  end
end