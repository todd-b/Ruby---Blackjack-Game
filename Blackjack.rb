#Blackjack Game

def calculate_total(cards)
  arr = cards.map{|e| e[1] }
  
  total = 0
  arr.each do |value|
    if value == "A"
    	total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end     
 
  #Aces
  arr.select{|e| e == "A"}.count.times do
  	total -= 10 if total > 21
  end

  total
end

puts "Lets Play Blackjack!"

suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

#Dealing Time!

playercards = []
dealercards = []

playercards << deck.pop
dealercards << deck.pop
playercards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
playertotal = calculate_total(playercards)

#Play Interaction Begins

puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}. Dealer total is #{dealertotal}."
puts "Your cards are: #{playercards[0]} and #{playercards [1]}. Your total is #{playertotal}."


if playertotal == 21
	puts "CONGRATULATIONS!  You hit Blackjack!  You WIN!"
	exit
end

while playertotal < 21
	puts "What is your next move? 1)hit or 2) stay?"
  hit_or_stay = gets.chomp

  if  !['1', '2'].include?(hit_or_stay)
  	puts "Error!  You must select 1) hits or 2) stay."
		next
  end

  #stay
  if hit_or_stay == "2"
  	puts "You chose to stay."
  	break
  end

  #hit
  new_card = deck.pop
  puts "Dealing a new card to player: #{new_card}"
  playercards << new_card
  playertotal = calculate_total(playercards)
  puts "Your new card total is: #{playertotal}"

  if playertotal == 21
  	puts "CONGRATULATIONS!  You hit Blackjack!  You WIN!"
  	exit
  elsif playertotal > 21
  	puts "BUSTED!  You lose this round."
  	exit
  end
end

#Dealer turn

if dealertotal == 21
	puts "Dealer WINS!  You lose!"
	exit
end

while dealertotal < 17
	#hit
	new_card = deck.pop
	puts "Dealer gets new card: #{new_card}"
	dealercards << new_card
	dealertotal = calculate_total(dealercards)
	puts "Dealer's total is now: #{dealertotal}"

	if dealertotal == 21
		puts "Dealer hit Blackjack. You lose!"
		exit
	elsif dealertotal > 21
		puts "Dealer BUSTED!  You WIN!!!"
		exit
	end
end	

#Compare Hands

puts "Dealer's hand: "
dealercards.each do |card|
	puts "=> #{card}"
end

puts "Your cards:"
playercards.each do |card|
	puts "=> #{card}"
end

if dealertotal > mytotal
	puts "Dealer wins!"
elsif dealertotal < playertotal
	puts "Congratulation!  You WIN!"
else
	puts "TIE!"
end

exit
	