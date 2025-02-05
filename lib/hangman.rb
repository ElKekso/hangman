guessed_letters = Hash.new
word = pick_word

def pick_word
  words = File.readlines('google-10000-english-no-swears.txt')
  words.sample
end

def get_guess
  puts "Please enter a single letter you did not guess yet:"
  while true
    ret = gets.chomp
    return ret if ret.count("a-zA-Z") > 0 && !guessed_letters.has_key?(ret)
  end
end

def show_progress
  word.chars.each {|char| 
  if guessed_letters.has_key?(char)
    print char
  else
    print '_'
  end
  #$stdout.flush 
}
end






