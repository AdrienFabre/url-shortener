require 'spec_helper'

describe Shortener do
  it 'creates a short url' do
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    allow(Shortener).to receive(:rand).and_return(0)
    url_pair = { 'url' => 'http://itakepart.org/' }
    expect(Shortener.process_url(url_pair)).to eq(
      'short_url' => 'aaaaaa', 'url' => 'http://itakepart.org/'
    )
  end

  it 'prevents creating a new short url if url is already saved' do
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    url_pair = { 'url' => 'http://itakepart.org/' }
    expect(Shortener.process_url(url_pair)).to eq(
      'short_url' => 'aaaaaa', 'url' => 'http://itakepart.org/'
    )
  end

  it ' retrieves a short url' do
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    short_url = 'aaaaaa'
    expect(Shortener.retrieve_pair_by_short_url(short_url)).to eq(
      'short_url' => 'aaaaaa', 'url' => 'http://itakepart.org/'
    )
  end
end
