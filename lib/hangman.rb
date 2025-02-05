def pick_word
  words = File.readlines('google-10000-english-no-swears.txt')
  word = words.sample
  loop do
    word.length <= 12 && word.length >= 5 ? break : word = words.sample
  end
end



def get_guess(guessed_letters)
  puts "Please enter a single letter you did not guess yet:"
  loop do
    ret = gets.chomp
    return ret if ret.count("a-zA-Z") > 0 && !guessed_letters.has_key?(ret)
  end
end

def get_progress(word, guessed_letters)
  fullword = ""
  word.chars.each {|char| 
  guessed_letters.has_key?(char) ? fullword << char : fullword << '_' }
  fullword
end

def check_guess(word)
  word.count("_") <= 0
end

def play_hangman
  num_guesses = 5
  word = pick_word
  guessed_letters = Hash.new

  puts get_progress(word, guessed_letters)
  for i in 0..num_guesses
    guessed_letters[get_guess(guessed_letters)] = 1
    progress = get_progress(word, guessed_letters)
    puts progress
    return "Congrats you win!" if check_guess(progress)
  end
  puts "The word was #{word}"
  return "You loose womp womp"
end

puts "Lets play Hangman :D"

puts play_hangman

