require 'spec_helper'

feature 'Scenario: user shortens a url' do
  scenario ' user can see instructions on the homepage' do
    visit '/'
    expect(page).to have_content 'Paste your URL! Get a short one!'
  end

  scenario 'user can paste an url an receive a short url' do
    visit '/'
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    allow(Shortener).to receive(:rand).and_return(2)
    fill_in 'urlBox', with: 'http://attitude-michele-joel.com/'
    click_button('Shorten')
    expect(page).to have_content 'cccccc'
  end
end
