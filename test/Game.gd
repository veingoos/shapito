extends Node

@onready var Card_1 = $Card_1
@onready var Card_2 = $Card_2
@onready var Card_3 = $Card_3
@onready var Card_4 = $Card_4
@onready var Card_5 = $Card_5
@onready var Card_6 = $Card_6
@onready var Card_7 = $Card_7

@onready var card_1_pressed: bool = false
@onready var card_2_pressed: bool = false
@onready var card_3_pressed: bool = false
@onready var card_4_pressed: bool = false
@onready var card_5_pressed: bool = false
@onready var card_6_pressed: bool = false
@onready var card_7_pressed: bool = false

@onready var Play_Hand = $Play_Hand
@onready var Discard = $Discard

@onready var My_Account = $My_Account
@onready var Required_Account = $Required_Account
@onready var Deck = $Deck
@onready var Move = $Move
@onready var Reset = $Reset

var deck = []
var hand = []

var move = 4
var reset = 3
var pressed = 0


func create_deck():
	var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
	var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
	
	for suit in suits:
		for rank in ranks:
			var card = {
				"suit": suit,
				"rank": rank
			}
			deck.append(card)
	
	return deck

func shuffle_deck(deck1):
	deck1.shuffle()
	return deck1

func deal_hand(deck1):
	while hand.size() < 7:
		if deck1.size() > 0:
			hand.append(deck1.pop_back())
	
	return hand


static func evaluate_hand(hand1: Array) -> int:
	if is_royal_flush(hand1):
		return 10
	elif is_straight_flush(hand1):
		return 9
	elif is_four_of_a_kind(hand1):
		return 8
	elif is_full_house(hand1):
		return 7
	elif is_flush(hand1):
		return 6
	elif is_straight(hand1):
		return 5
	elif is_three_of_a_kind(hand1):
		return 4
	elif is_two_pair(hand1):
		return 3
	elif is_one_pair(hand1):
		return 2
	else:
		return 1

static func get_ranks(hand1: Array):
	var ranks = []
	var rank_order2 = {"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "Jack": 11, "Queen": 12, "King": 13, "Ace": 14}
	for card in hand1:
		ranks.append(rank_order2[str(card["rank"])])
	ranks.sort()
	return ranks

static func get_suits(hand1: Array):
	var suits = []
	for card in hand1:
		suits.append(card["suit"])
	return suits

static func rank_counts(hand1: Array):
		var counts = {}
		var rank_order2 = {"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "Jack": 11, "Queen": 12, "King": 13, "Ace": 14}
		for card in hand1:
			if counts.has(rank_order2[str(card["rank"])]):
				counts[rank_order2[str(card["rank"])]] += 1
			else:
				counts[rank_order2[str(card["rank"])]] = 1
		return counts

static func is_flush(hand1: Array):
	var suits = get_suits(hand1)
	return suits.count(suits[0]) == 5

static func is_straight(hand1: Array):
	var ranks = get_ranks(hand1)
	var normal = true
	for i in range(1,5):
		if ranks[i] != ranks[i-1] + 1:
			normal = false
			break
	if normal:
		return true
	
	if ranks == [2,3,4,5,14]:
		return true
	return false
	
static func is_straight_flush(hand1: Array):
	return is_straight(hand1) and is_flush(hand1)

static func is_royal_flush(hand1: Array):
	if not is_flush(hand1):
		return false
	var ranks = get_ranks(hand1)
	return ranks == [10,11,12,13,14]

static func is_four_of_a_kind(hand1: Array):
	var counts = rank_counts(hand1)
	return 4 in counts

static func is_full_house(hand1: Array):
	var counts = rank_counts(hand1)
	return 3 in counts and 2 in counts

static func is_three_of_a_kind(hand1: Array):
	var counts = rank_counts(hand1)
	return 3 in counts and 2 not in counts

static func is_two_pair(hand1: Array):
	var pairs = 0
	for count in rank_counts(hand1):
		if int(count) == 2:
			pairs += 1
	return pairs == 2

static func is_one_pair(hand1: Array):
	var counts = rank_counts(hand1)
	return counts.count(2) == 1



func move_cards():
	move -= 1
	
	var indices = []
	hand.reverse()
	
	while true:
		if indices.size() <= 5:
			if pressed <= 5:
				if card_1_pressed:
					indices.append(hand[6])
					hand.remove_at(6)
					card_1_pressed = false
					pressed -= 1
				if card_2_pressed:
					indices.append(hand[5])
					hand.remove_at(5)
					card_2_pressed = false
					pressed -= 1
				if card_3_pressed:
					indices.append(hand[4])
					hand.remove_at(4)
					card_3_pressed = false
					pressed -= 1
				if card_4_pressed:
					indices.append(hand[3])
					hand.remove_at(3)
					card_4_pressed = false
					pressed -= 1
				if card_5_pressed:
					indices.append(hand[2])
					hand.remove_at(2)
					card_5_pressed = false
					pressed -= 1
				if card_6_pressed:
					indices.append(hand[1])
					hand.remove_at(1)
					card_6_pressed = false
					pressed -= 1
				if card_7_pressed:
					indices.append(hand[0])
					hand.remove_at(0)
					card_7_pressed = false
					pressed -= 1
			else:
				print("Выберите 5 карт или меньше")
				if card_1_pressed:
					card_1_pressed = false
					pressed -= 1
				if card_2_pressed:
					card_2_pressed = false
					pressed -= 1
				if card_3_pressed:
					card_3_pressed = false
					pressed -= 1
				if card_4_pressed:
					card_4_pressed = false
					pressed -= 1
				if card_5_pressed:
					card_5_pressed = false
					pressed -= 1
				if card_6_pressed:
					card_6_pressed = false
					pressed -= 1
				if card_7_pressed:
					card_7_pressed = false
					pressed -= 1
				hand.reverse()
				move += 1
				continue
		break
	
	var rank_order = {"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "Jack": 10, "Queen": 10, "King": 10, "Ace": 11}
	var _total_account: int = 0
	var combo_id = evaluate_hand(indices)
	var combo: int = 1
	match combo_id:
		10:
			combo = 10
		9:
			combo = 9
		8:
			combo = 8
		7:
			combo = 7
		6:
			combo = 6
		5:
			combo = 5
		4:
			combo = 4
		3:
			combo = 3
		2:
			combo = 2
		1:
			combo = 1
	
	
	for ind in indices:
		_total_account += rank_order[str(ind["rank"])]
	_total_account *= combo
	Record.my_account = Record.my_account + _total_account
	
	indices.clear()
	
	hand = deal_hand(deck)
	
	Deck.text = str(deck.size()) + " карт"
	My_Account.text = str(Record.my_account) + "очков"
	
	Card_1.text = str(hand[0]["rank"]) + " " + str(hand[0]["suit"])
	Card_2.text = str(hand[1]["rank"]) + " " + str(hand[1]["suit"])
	Card_3.text = str(hand[2]["rank"]) + " " + str(hand[2]["suit"])
	Card_4.text = str(hand[3]["rank"]) + " " + str(hand[3]["suit"])
	Card_5.text = str(hand[4]["rank"]) + " " + str(hand[4]["suit"])
	Card_6.text = str(hand[5]["rank"]) + " " + str(hand[5]["suit"])
	Card_7.text = str(hand[6]["rank"]) + " " + str(hand[6]["suit"])
	
	Move.text = str(move) + " хода"
	
	
	if move < 1:
		get_tree().change_scene_to_file("res://control.tscn")

func replace_cards():
	if reset >=  1:
	
		var indices = []
		hand.reverse()
	
		while true:
			if indices.size() <= 5:
				if pressed <= 5:
					if card_1_pressed:
						indices.append(hand[6])
						hand.remove_at(6)
						card_1_pressed = false
						pressed -= 1
					if card_2_pressed:
						indices.append(hand[5])
						hand.remove_at(5)
						card_2_pressed = false
						pressed -= 1
					if card_3_pressed:
						indices.append(hand[4])
						hand.remove_at(4)
						card_3_pressed = false
						pressed -= 1
					if card_4_pressed:
						indices.append(hand[3])
						hand.remove_at(3)
						card_4_pressed = false
						pressed -= 1
					if card_5_pressed:
						indices.append(hand[2])
						hand.remove_at(2)
						card_5_pressed = false
						pressed -= 1
					if card_6_pressed:
						indices.append(hand[1])
						hand.remove_at(1)
						card_6_pressed = false
						pressed -= 1
					if card_7_pressed:
						indices.append(hand[0])
						hand.remove_at(0)
						card_7_pressed = false
						pressed -= 1
				else:
					print("Выберите 5 карт или меньше")
					if card_1_pressed:
						card_1_pressed = false
						pressed -= 1
					if card_2_pressed:
						card_2_pressed = false
						pressed -= 1
					if card_3_pressed:
						card_3_pressed = false
						pressed -= 1
					if card_4_pressed:
						card_4_pressed = false
						pressed -= 1
					if card_5_pressed:
						card_5_pressed = false
						pressed -= 1
					if card_6_pressed:
						card_6_pressed = false
						pressed -= 1
					if card_7_pressed:
						card_7_pressed = false
						pressed -= 1
					hand.reverse()
					reset += 1
					continue
			break
		hand = deal_hand(deck)
		reset -= 1
	else:
		print("Сбросов нет")
		pass
	
	
	Card_1.text = str(hand[0]["rank"]) + " " + str(hand[0]["suit"])
	Card_2.text = str(hand[1]["rank"]) + " " + str(hand[1]["suit"])
	Card_3.text = str(hand[2]["rank"]) + " " + str(hand[2]["suit"])
	Card_4.text = str(hand[3]["rank"]) + " " + str(hand[3]["suit"])
	Card_5.text = str(hand[4]["rank"]) + " " + str(hand[4]["suit"])
	Card_6.text = str(hand[5]["rank"]) + " " + str(hand[5]["suit"])
	Card_7.text = str(hand[6]["rank"]) + " " + str(hand[6]["suit"])
	
	Reset.text = str(reset) + " сбросов"
	Deck.text = str(deck.size()) + " карт"

func _ready():
	
	print(pressed)
	Card_1.pressed.connect(_if_button_pressed.bind(1))
	Card_2.pressed.connect(_if_button_pressed.bind(2))
	Card_3.pressed.connect(_if_button_pressed.bind(3))
	Card_4.pressed.connect(_if_button_pressed.bind(4))
	Card_5.pressed.connect(_if_button_pressed.bind(5))
	Card_6.pressed.connect(_if_button_pressed.bind(6))
	Card_7.pressed.connect(_if_button_pressed.bind(7))
	
	Play_Hand.pressed.connect(_if_button_pressed.bind(8))
	Discard.pressed.connect(_if_button_pressed.bind(9))
	
	deck = create_deck()
	deck = shuffle_deck(deck)
	hand = deal_hand(deck)
	
	Card_1.text = str(hand[0]["rank"]) + " " + str(hand[0]["suit"])
	Card_2.text = str(hand[1]["rank"]) + " " + str(hand[1]["suit"])
	Card_3.text = str(hand[2]["rank"]) + " " + str(hand[2]["suit"])
	Card_4.text = str(hand[3]["rank"]) + " " + str(hand[3]["suit"])
	Card_5.text = str(hand[4]["rank"]) + " " + str(hand[4]["suit"])
	Card_6.text = str(hand[5]["rank"]) + " " + str(hand[5]["suit"])
	Card_7.text = str(hand[6]["rank"]) + " " + str(hand[6]["suit"])
	
	Move.text = str(move) + " хода"
	Reset.text = str(reset) + " сбросов"
	
	Deck.text = str(deck.size()) + " карт"
	My_Account.text = str(Record.my_account) + "очков"

func _if_button_pressed(button_index: int):
	match button_index:
		1:
			if card_1_pressed:
				Card_1.text = str(hand[0]["rank"]) + " " + str(hand[0]["suit"])
				card_1_pressed = false
				pressed -= 1
				print(pressed)
			else:
				Card_1.text = str(hand[0]["rank"]) + " " + str(hand[0]["suit"]) + " Выбр."
				card_1_pressed = true
				pressed += 1
				print(pressed)
		2:
			if card_2_pressed:
				Card_2.text = str(hand[1]["rank"]) + " " + str(hand[1]["suit"])
				card_2_pressed = false
				pressed -= 1
				print(pressed)
			else:
				Card_2.text = str(hand[1]["rank"]) + " " + str(hand[1]["suit"]) + " Выбр."
				card_2_pressed = true
				pressed += 1
				print(pressed)
		3:
			if card_3_pressed:
				Card_3.text = str(hand[2]["rank"]) + " " + str(hand[2]["suit"])
				card_3_pressed = false
				pressed -= 1
				print(pressed)
			else:
				Card_3.text = str(hand[2]["rank"]) + " " + str(hand[2]["suit"]) + " Выбр."
				card_3_pressed = true
				pressed += 1
				print(pressed)
		4:
			if card_4_pressed:
				Card_4.text = str(hand[3]["rank"]) + " " + str(hand[3]["suit"])
				card_4_pressed = false
				pressed -= 1
				print(pressed)
			else:
				Card_4.text = str(hand[3]["rank"]) + " " + str(hand[3]["suit"]) + " Выбр."
				card_4_pressed = true
				pressed += 1
				print(pressed)
		5:
			if card_5_pressed:
				Card_5.text = str(hand[4]["rank"]) + " " + str(hand[4]["suit"])
				card_5_pressed = false
				pressed -= 1
				print(pressed)
			else:
				Card_5.text = str(hand[4]["rank"]) + " " + str(hand[4]["suit"]) + " Выбр."
				card_5_pressed = true
				pressed += 1
				print(pressed)
		6:
			if card_6_pressed:
				Card_6.text = str(hand[5]["rank"]) + " " + str(hand[5]["suit"])
				card_6_pressed = false
				pressed -= 1
				print(pressed)
			else:
				Card_6.text = str(hand[5]["rank"]) + " " + str(hand[5]["suit"]) + " Выбр."
				card_6_pressed = true
				pressed += 1
				print(pressed)
		7:
			if card_7_pressed:
				Card_7.text = str(hand[6]["rank"]) + " " + str(hand[6]["suit"])
				card_7_pressed = false
				pressed -= 1
				print(pressed)
			else:
				Card_7.text = str(hand[6]["rank"]) + " " + str(hand[6]["suit"]) + " Выбр."
				card_7_pressed = true
				pressed += 1
				print(pressed)
		8:
			move_cards()
			
		9:
			replace_cards()
