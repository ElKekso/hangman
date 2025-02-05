def pick_word
  words = File.readlines('google-10000-english-no-swears.txt')
  words.sample
end

word = pick_word
guessed_letters = Hash.new

def get_guess
  puts "Please enter a single letter you did not guess yet:"
  while true
    ret = gets.chomp
    return ret if ret.count("a-zA-Z") > 0 && !guessed_letters.has_key?(ret)
  end
end

def get_progress(word, guessed_letters)
  fullword = ""
  word.chars.each {|char| 
  guessed_letters.has_key?(char) ? fullword << char : fullword << '_' }
  fullworld
end

