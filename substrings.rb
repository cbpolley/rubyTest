dictionary = %w[below down go going horn how howdy it i low own part partner sit]

def substrings(search_word, location)
  sterilise_search_word = search_word.downcase.gsub(/(\W|\d)/, '')

  my_hash = {}

  location.each do |word|
    my_hash[word] = sterilise_search_word.scan(word).count if sterilise_search_word.scan(word).count.positive?
  end
  
  my_hash
end

substrings("Howdy partner, sit down! How's it going?", dictionary)