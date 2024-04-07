# ----------------------------------------- #
#       Class pour la gestion du Jeu        #
# ----------------------------------------- #

class Game

  attr_accessor :responses

  # constructeur
  def initialize(array, max)

    @combination = array
    @max_responses = max
    @nb_responses = 0
    @responses = Array.new(max) { [0, 0, 0, 0] }

  end

  # fonction d'affichage de la combinaison
  def display

    for element in @combination

      case element
      when 1
        print "J "
      when 2
        print "B "
      when 3
        print "R "
      when 4
        print "V "
      when 5
        print "C "
      when 6
        print "N "
      else
        print "? "
      end

    end
    puts

  end

  # fonction d'affichage des essais
  def tries

    @responses.each_with_index do |response, index|

      if response != [0, 0, 0, 0]

        puts "Essai n°#{index+1}:"
        nb_good_color = 0
        nb_good_placement = 0

        for element in response

          # on vérifie si l'élément est dans la combinaison
          if @combination.include?(element)
            nb_good_color += 1
          end

          # on vérifie si l'élément est bien placé
          @combination.each_with_index do |second_element, second_index|
            if element == second_element and index == second_index
             nb_good_placement += 1
            end
          end

        end

        puts "  #{nb_good_color} pin(s) sont de la même couleur, #{nb_good_placement} pin(s) sont bien placés"

      end
    end

  end

  # fonction de vérification de la combinaison
  def check(guess)

    # on ajoute la réponse à la liste des réponses
    @responses[@nb_responses] = guess
    @nb_responses += 1

    nb_good_color = 0
    nb_good_placement = 0

    guess.each_with_index do |element, index|

      # on vérifie si l'élément est dans la combinaison
      if @combination.include?(element)
        nb_good_color += 1
      end

      # on vérifie si l'élément est bien placé
      @combination.each_with_index do |second_element, second_index|
        if element == second_element and index == second_index
          nb_good_placement += 1
        end
      end

    end

    puts "#{nb_good_color} pin(s) sont de la même couleur, #{nb_good_placement} pin(s) sont bien placés"

  end

  def win?
    @combination == @responses.last
  end

  def loose?
    @nb_responses == @max_responses
  end

end
