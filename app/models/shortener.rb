require 'json'

class Shortener
  FILE = './url_pairs.json'.freeze
  HTTP_REGEX = %r{https?:\/\/[\S]+}.freeze

  def self.create_short_url(url_pair)
    url_pair['url'] = format_url(url_pair['url'])
    url_pair.store('short_url', generate_short_url)
    url_pairs = retrieve_saved_urls
    url_pairs << url_pair
    save_to_file(url_pairs)
    url_pair
  end

  def self.retrieve_url(short_url)
    url_pairs = retrieve_saved_urls
    url_pairs.map do |url_pair|
      if url_pair['short_url'] == short_url
        return url_pair.select { |k| k == 'url' }
      end
    end
  end

  def self.generate_short_url(length = 6)
    source = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
    short_url = ''
    length.times { short_url += source[rand(source.size)].to_s }
    short_url
  end

  def self.retrieve_saved_urls
    File.file?(FILE) ? JSON.parse(File.read(FILE)) : []
  end

  def self.format_url(url)
    !(url =~ HTTP_REGEX).nil? ? url : "http://#{url}"
  end

  def self.save_to_file(url_pairs)
    File.open(FILE, 'w') { |file| file.puts JSON.pretty_generate(url_pairs) }
  end

  private_class_method :generate_short_url,
                       :retrieve_saved_urls,
                       :format_url,
                       :save_to_file
end
