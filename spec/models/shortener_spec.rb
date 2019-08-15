require 'spec_helper'

describe Shortener do
  it 'creates a short url' do
    stub_const('Shortener::FILE', 'url_pairs_test.json')

    allow(Shortener).to receive(:rand).and_return(0)
    url_pair = { 'url' => 'http://itakepart.org/' }
    expect(Shortener.create_short_url(url_pair)).to eq(
      { 'short_url' => 'aaaaaa', 'url' => 'http://itakepart.org/' }
    )
  end

  it ' retrieves a short url' do
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    short_url = 'aaaaaa'
    expect(Shortener.retrieve_url(short_url)).to eq(
      { 'url' => 'http://itakepart.org/' }
    )
  end
end
