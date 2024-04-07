require_relative 'game'

class Main
  attr_accessor :nb_tries, :combinaison, :game

  def initialize
    @nb_tries = 5
    @combinaison = generate_combinaison
    @game = Game.new(@combinaison, @nb_tries)
    @run = true
  end

  def generate_combinaison

    combi = [0, 0, 0, 0]
    i = 0
    while i != 4
      nb = rand(1..6)
      if !combi.include?(nb)
        combi[i] = nb
        i += 1
      end
    end

    return combi


  end

  def loop
    puts " _  _   ___   ____  ____  ____  ____     _  _   __   __ _  ____ "
    puts "( \\/ ) / _ \\ / ___)(_  _)(  __)(  _ \\   ( \\/ ) /  \\ (  ( \\(    \\"
    puts "/ \\/ \\(__  ( \\___ \\  )(   ) _)  )   /   / \\/ \\(_/ / /    / ) D ("
    puts "\\_)(_/  (__/ (____/ (__) (____)(__\\_)   \\_)(_/ (__) \\_)__)(____/  by L4KK4S for Ludiversales Project "
    puts "\n\nBienvenue dans le jeu Mastermind en ruby!\nTapez 'help' pour afficher l'aide"

    while @run
      print "\n>>"
      command = gets.chomp
      arguments = command.split(" ")

      case arguments[0]

      when "help"
        puts "clear               : effacer l'écran"
        puts "rep                 : afficher la combinaison à trouver"
        puts "combi x1 x2 ... xn  : essayer une combinaison"
        puts "lives               : afficher le nombre d'essais restants"
        puts "hist                : afficher l'historique des essais"
        puts "exit                : quitter le jeu"

      when "clear"
        if RUBY_PLATFORM.include?("linux") || RUBY_PLATFORM.include?("darwin")
          system("clear")
        else
          system("cls")
        end


      when "rep"
        @game.display(@combinaison)

      when "combi"
        if arguments.length != 5
          puts "Erreur: nombre d'arguments incorrect"
        else
          @game.check(arguments[1..-1].map(&:to_i))
        end

      when "lives"
        puts "Il vous reste #{@nb_tries - @game.nb_responses} essais"

      when "hist"
        @game.tries

      when "exit"
        break
      else
        puts "Erreur: Commande inconnue"
      end

      if @game.win?
        puts "Bravo, vous avez gagné!"
        @run = false
      elsif @game.loose?
        puts "Dommage, vous avez perdu!"
        puts "La combinaison était: "
        @game.display(@combinaison)
        @run = false
      end

    end
  end


end

if __FILE__ == $0
  puts RUBY_PLATFORM
  game = Main.new
  game.loop
end
