require_relative 'game'

class Main

  def initialize()

    @nb_tries = 5
    @combination = [1, 2, 3, 4]
    @game = Game.new(@combination, @nb_tries)

  end

  def self.main
    puts " _  _   ___   ____  ____  ____  ____     _  _   __   __ _  ____ "
    puts "( \\/ ) / _ \\ / ___)(_  _)(  __)(  _ \\   ( \\/ ) /  \\ (  ( \\(    \\"
    puts "/ \\/ \\(__  ( \\___ \\  )(   ) _)  )   /   / \\/ \\(_/ / /    / ) D ("
    puts "\\_)(_/  (__/ (____/ (__) (____)(__\\_)   \\_)(_/ (__) \\_)__)(____/  by L4KK4S for Ludiversales Project "
    puts "\n\nBienvenue dans le jeu Mastermind en ruby!\nTapez 'help' pour afficher l'aide"

  end

  def display_commands

    print "combinaison [x1, x2, ..., xn] : essaie combinaison\n"
    print "lives : affiche le nombre d'essais restants\n"
    print "historic : affiche l'historique des essais\n"
    print "exit : quitter le jeu\n"

  end

  def get_command

    print "Entrez une commande: "
    command = gets.chomp

    return command

  end



end

if __FILE__ == $0
  Main.main
end