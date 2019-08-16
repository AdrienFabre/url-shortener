require 'json'

class Shortener
  FILE = './url_pairs.json'.freeze
  RAND_SOURCE = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a

  def self.process_url(url_pair)
    saved_urls = retrieve_saved_urls
    if url_already_saved?(url_pair['url'], saved_urls)
      retrieve_pair_by_url(url_pair['url'], saved_urls)
    else
      bind_short_url(url_pair, saved_urls)
    end
  end

  def self.retrieve_pair_by_short_url(short_url)
    retrieve_saved_urls.map do |url_pair|
      return url_pair if url_pair['short_url'] == short_url
    end
  end

  def self.retrieve_pair_by_url(url, saved_urls)
    saved_urls.map { |url_pair| return url_pair if url_pair['url'] == url }
  end

  def self.url_already_saved?(url, saved_urls)
    urls = saved_urls.map { |pair| pair['url'] }
    urls.include?(url)
  end

  def self.bind_short_url(url_pair, saved_urls)
    short_urls = saved_urls.map { |pair| pair['short_url'] }
    short_url = ''
    loop do
      short_url = generate_short_url
      break unless short_urls.include?(short_url)
    end
    url_pair.store('short_url', short_url)
    saved_urls << url_pair
    save_to_file(saved_urls)
    url_pair
  end

  def self.generate_short_url(length = 6)
    short_url = ''
    length.times { short_url += RAND_SOURCE[rand(RAND_SOURCE.size)].to_s }
    short_url
  end

  def self.retrieve_saved_urls
    File.file?(FILE) ? JSON.parse(File.read(FILE)) : []
  end

  def self.save_to_file(saved_urls)
    File.open(FILE, 'w') { |file| file.puts JSON.pretty_generate(saved_urls) }
  end

  private_class_method :retrieve_pair_by_url,
                       :generate_short_url,
                       :url_already_saved?,
                       :retrieve_saved_urls,
                       :save_to_file
end
