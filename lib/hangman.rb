require 'json'

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
  puts gen_progress(word, guessed_letters)
  num_guesses.downto(1) do |i|
    if check_progress(get_progress(word, guessed_letters))
      puts "Congrats you win!"
      return
    end
    puts "You have #{i - 1} guesses left!"
    puts "Do you want to save the game?"
    if get_yn
      Dir.mkdir('saves') unless Dir.exist?('saves')
      puts "please input a save name"
      filename = "saves/#{gets.chomp}.json"
      temp_hash = {
        "word": word,
        "guessed_letters": guessed_letters,
        "num_guesses": i - 1
      }
      File.open(filename, 'w') do |file|
        file.write(temp_hash.to_json)
      end
      return 
    end

  end
  puts "The word was #{word}"
  puts "You loose womp womp"
  return
end

def get_yn
  print " (y = yes) (n = no)\n"
  loop do 
    input = gets.chomp
    if input == 'y'
      return true
    elsif input == 'n'
      return false
    else
      puts "Please try again"
    end
  end
end

puts "Lets play Hangman :D"

guessed_letters = Hash.new
word = pick_word
num_guesses = 5

puts "Do you want to load a game?"
if get_yn
  puts "Enter the name of the save file you want to continue"
  loop do
    filename = gets.chomp
    next unless File.exist?("saves/#{filename}.json")
    file = open("saves/#{filename}.json")
    game_save = JSON.parse(file.read)
    guessed_letters = game_save["guessed_letters"]
    word = game_save["word"]
    num_guesses = game_save["num_guesses"]
    break
  end
end



game_loop(num_guesses, word, guessed_letters)

