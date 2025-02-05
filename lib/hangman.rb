def pick_word
  words = File.readlines('google-10000-english-no-swears.txt')
  word = words.sample[0..-2]
  loop do
    word.length <= 12 && word.length >= 5 ? break : word = words.sample[0..-2]
  end
  word
end



def get_guess(guessed_letters)
  loop do
    puts "Do you want to input a letter (1) or a word (2)?"
    input = gets.chomp
    if input == '1'
      guessed_letters[get_letter(guessed_letters)] = 1; return false
    elsif input == '2'
      return get_word
    end
  end
end

def get_letter(guessed_letters)
  puts "Please enter a single letter you did not guess yet:"
  loop do
    ret = gets.chomp
    return ret if ret.count("a-zA-Z") > 0 && !guessed_letters.has_key?(ret)
  end
end

def get_word
  puts "Please enter a word:"
  loop do
    ret = gets.chomp
    return ret if ret.count("a-zA-Z") == ret.length
  end
end

def gen_progress(word, guessed_letters)
  fullword = ""
  word.chars.each {|char| 
  guessed_letters.has_key?(char) ? fullword << char : fullword << '_' }
  fullword
end

def check_progress(word)
  word.count("_") <= 0
end

def get_progress(word, guessed_letters)
  guess = get_guess(guessed_letters)
  if guess == word
    word
  else
    progress = gen_progress(word, guessed_letters)
    puts progress
    progress
  end
end

def game_loop(num_guesses, word, guessed_letters)
  puts word
  puts word.chars
  puts gen_progress(word, guessed_letters)
  for i in 0..num_guesses
    return "Congrats you win!" if check_progress(get_progress(word, guessed_letters))
  end
  puts "The word was #{word}"
  return "You loose womp womp"
end

def play_hangman
  game_loop(5, pick_word, Hash.new)
end



puts "Lets play Hangman :D"

puts play_hangman

