def pick_word
  words = File.readlines('google-10000-english-no-swears.txt')
  words.sample
end

puts pick_word



