require_relative 'game'

class Main

  # accesseurs pour les variables d'instance
  attr_accessor :nb_tries, :combinaison, :game, :run, :nb_pins

  # constructeur
  def initialize
    @nb_tries = 0
    @nb_pins = 0
    self.read_settings
    @combinaison = generate_combinaison
    @game = Game.new(@combinaison, @nb_tries, @nb_pins)
    @run = true
  end

  # fonction pour générer une combinaison aléatoire
  def generate_combinaison

    combi = Array.new(@nb_pins, 0)
    i = 0
    while i != @nb_pins
      nb = rand(1..6)
      if !combi.include?(nb)
        combi[i] = nb
        i += 1
      end
    end

    return combi

  end

  # fonction pour lire les paramètres de la partie
  def read_settings
    file = File.open("save.txt", "r")
    lines = file.readlines
    file.close
    puts lines[0]
    puts lines[1]
    @nb_tries = lines[0].to_i
    @nb_pins = lines[1].to_i
  end

  # fonction pour sauvegarder les paramètres de la partie
  def save_settings
    file = File.open("save.txt", "w")
    file.puts @nb_tries
    file.puts @nb_pins
    file.close
  end

  # fonction pour lancer la boucle principale du jeu
  def loop
    puts " _  _   ___   ____  ____  ____  ____     _  _   __   __ _  ____ "
    puts "( \\/ ) / _ \\ / ___)(_  _)(  __)(  _ \\   ( \\/ ) /  \\ (  ( \\(    \\"
    puts "/ \\/ \\(__  ( \\___ \\  )(   ) _)  )   /   / \\/ \\(_/ / /    / ) D ("
    puts "\\_)(_/  (__/ (____/ (__) (____)(__\\_)   \\_)(_/ (__) \\_)__)(____/  by L4KK4S for Ludiversales Project "
    puts "\n\nBienvenue dans le jeu Mastermind en ruby!\nTapez 'help' pour afficher l'aide"

    # tant que le jeu est en cours
    while @run
      print "\n>>"                                                 # affichage du prompt
      command = gets.chomp                                         # lecture de la commande
      arguments = command.split(" ")                       # séparation des arguments


      case arguments[0]                                           # analyse de la commande

      when "help"                                                 # affichage de l'aide
        puts "\nclear                      : effacer l'écran"
        puts "param -[option]             : modifier les paramètres"
        puts "      -d                    : afficher les paramètres de la partie"
        puts "      -c [live] [nb pins]   : modifier le nombre d'essais et le nombre de pins"
        puts "      -s                    : sauvegarder les paramètres"
        puts "rep                         : afficher la combinaison à trouver"
        puts "combi x1 x2 ... xn          : essayer une combinaison"
        puts "lives                       : afficher le nombre d'essais restants"
        puts "hist                        : afficher l'historique des essais"
        puts "restart                     : redémarrer le jeu"
        puts "exit                        : quitter le jeu"

      when "clear"                                                # effacement de l'écran
        if RUBY_PLATFORM.include?("linux") || RUBY_PLATFORM.include?("darwin")
          system("clear")
        else
          system("cls")
        end

      when "param"                                                # action sur les paramètres
        if [2, 4].include? arguments.length
          if arguments[1] == "-d"
            puts "Nombre d'essais: #{@nb_tries}"
            puts "Nombre de pins: #{@nb_pins}"
          elsif arguments[1] == "-c"
            if arguments.length != 4
              puts "Erreur: nombre d'arguments incorrect"
            else
              @nb_tries = arguments[2].to_i
              @nb_pins = arguments[3].to_i
            end
          elsif arguments[1] == "-s"
            puts "Sauvegarde des paramètres"
            save_settings
          else
            puts "Erreur: option inconnue"
          end
        else
          puts "Erreur: nombre d'arguments incorrect"
        end

      when "rep"                                                # affichage de la combinaison
        @game.display(@combinaison)

      when "combi"                                              # essai d'une combinaison
        if arguments.length != @nb_pins + 1
          puts "Erreur: nombre d'arguments incorrect"
        else
          @game.check(arguments[1..-1].map(&:to_i))
        end

      when "lives"                                            # affichage du nombre d'essais restants
        puts "Il vous reste #{@nb_tries - @game.nb_responses} essais"

      when "hist"                                             # affichage de l'historique des essais
        @game.tries

      when "restart"                                          # redémarrage du jeu
        @combinaison = generate_combinaison
        @game = Game.new(@combinaison, @nb_tries, @nb_pins)

      when "exit"                                             # sortie du jeu
        break

      else                                                   # commande inconnue
        puts "Erreur: Commande inconnue"
      end


      if @game.win?                                           # vérification de la victoire
        puts "\nBravo, vous avez gagné!"
        @run = false
      elsif @game.loose?                                      # vérification de la défaite
        puts "\nDommage, vous avez perdu!"
        puts "La combinaison était: "
        @game.display(@combinaison)
        @run = false
      end

      if !@run                                               # demande de rejouer
        puts "\nVoulez-vous rejouer? (o/n)"
        print ">>"
        answer = gets.chomp
        while answer != "o" and answer != "n"
          puts "Réponse invalide"
          print ">>"
          answer = gets.chomp
        end
        if answer == "o"
          @combinaison = generate_combinaison
          @game = Game.new(@combinaison, @nb_tries, @nb_pins)
          @run = true
        else
          @run = false
        end
      end

    end
  end


end

# si le fichier est exécuté
if __FILE__ == $0
  game = Main.new
  game.loop
end
