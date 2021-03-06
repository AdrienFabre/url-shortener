require 'spec_helper'

feature 'Scenario: user shortens a url' do
  scenario ' user can see instructions on the homepage' do
    visit '/'
    expect(page).to have_content 'Paste your URL'
    expect(page).to have_content 'Fill the box with a valid url!'
  end

  scenario 'user can paste an url an receive a short url' do
    visit '/'
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    allow(Shortener).to receive(:rand).and_return(2)
    fill_in 'urlBox', with: 'http://attitude-michele-joel.com/'
    click_button('Shorten')
    expect(page).to have_content 'cccccc'
  end

  scenario 'user can visit the new created link to be redirected' do
    visit '/'
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    allow(Shortener).to receive(:rand).and_return(4)
    fill_in 'urlBox', with: 'https://twitter.com/adrienfabre1'
    click_button('Shorten')
    expect(page).to have_content 'eeeeee'
    visit '/eeeeee'
    expect(current_url).to eql('https://twitter.com/adrienfabre1')
  end

  scenario 'user can click on the new created link to be redirected' do
    visit '/'
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    allow(Shortener).to receive(:rand).and_return(3)
    fill_in 'urlBox', with: 'https://www.linkedin.com/in/adrienfabre/'
    click_button('Shorten')
    expect(page).to have_content 'dddddd'
    find('#linkUrl').click
    expect(current_url).to eql('https://www.linkedin.com/in/adrienfabre/')
  end

  scenario 'user can read a message if empty url is submited' do
    visit '/'
    fill_in 'urlBox', with: ''
    click_button('Shorten')
    expect(page).to have_content 'Fill the box with a valid url!'
  end

  scenario 'user read a message if unvalid url is submited' do
    visit '/'
    fill_in 'urlBox', with: 'http://attitude'
    click_button('Shorten')
    expect(page).to have_content 'Fill the box with a valid url!'
  end
end
