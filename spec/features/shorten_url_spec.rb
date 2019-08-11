require 'spec_helper'

feature 'shorten url' do
  scenario 'see the homepage with instructions' do
    visit '/'
    expect(page).to have_content 'Enter an URL'
  end
end