extends Node

@onready var test = $Button


@onready var Card_1 = $ColorRect/Card_1
@onready var Card_2 = $ColorRect/Card_2
@onready var Card_3 = $ColorRect/Card_3
@onready var Card_4 = $ColorRect/Card_4
@onready var Card_5 = $ColorRect/Card_5
@onready var Card_6 = $ColorRect/Card_6
@onready var Card_7 = $ColorRect/Card_7

@onready var card_1_pressed: bool = false
@onready var card_2_pressed: bool = false
@onready var card_3_pressed: bool = false
@onready var card_4_pressed: bool = false
@onready var card_5_pressed: bool = false
@onready var card_6_pressed: bool = false
@onready var card_7_pressed: bool = false

@onready var Play_Hand = $ColorRect/Play_Hand
@onready var Discard = $ColorRect/Discard

@onready var My_Account = $ColorRect/My_Account
@onready var Required_Account = $ColorRect/Required_Account
@onready var Deck = $ColorRect/Deck
@onready var Move = $ColorRect/Move
@onready var Reset = $ColorRect/Reset

var deck = []
var hand = []
var jokers = Record.jokers


var move = 4
var reset = 3
var pressed = 0

func Card(suit,rank,imgcard):
	return {
				"suit": suit,
				"rank": rank,
				"imgcard": imgcard
				}


func create_deck():
	var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
	var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
	
	for suit in suits:
		for rank in ranks:
			deck.append(Card(suit,rank,suit+rank))
			
	
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
	
	
static func is_one_pair(hand1: Array):
	var counts = rank_counts(hand1)
	if len(counts) > 1:
		return false
	
static func is_flush(hand1: Array):
	var suits = get_suits(hand1)
	if len(suits)<5:
		return false
	return suits.count(suits[0]) == 5

static func is_straight(hand1: Array):
	var ranks = get_ranks(hand1)
	if len(ranks)<5:
		return false
	if ranks == [2,3,4,5,14]:
		return true
	
		
	for i in range(1,5):
		if ranks[i] != ranks[i-1] + 1:
			return false

	return true

static func is_straight_flush(hand1: Array):
	return is_straight(hand1) and is_flush(hand1)

static func is_royal_flush(hand1: Array):
	if not is_flush(hand1):
		return false
	var ranks = get_ranks(hand1)
	return ranks == [10,11,12,13,14]

static func is_four_of_a_kind(hand1: Array):
	var counts = rank_counts(hand1)

	return 4 in counts.values()

static func is_full_house(hand1: Array):
	var counts = rank_counts(hand1)
	return 3 in counts and 2 in counts

static func is_three_of_a_kind(hand1: Array):
	var counts = rank_counts(hand1)
	
	return 3 in counts.values() and 2 not in counts.values()

static func is_two_pair(hand1: Array):
	var pairs = 0
	for count in rank_counts(hand1).values():
		if int(count) == 2:
			pairs += 1
	return pairs == 2






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
	print(combo_id)
	var combo: int = 1
	match combo_id:
		10:
			combo += 9
		9:
			combo += 8
		8:
			combo += 7
		7:
			combo += 6
		6:
			combo += 5
		5:
			combo += 4
		4:
			combo += 3
		3:
			combo += 2
		2:
			combo += 1
		1:
			combo += 0
	
	var _suits = get_suits(indices)
	print(get_suits(indices))
	for i in jokers:
		var suit_joker = i[1]
		for ind in _suits:
			if ind == suit_joker:
				_total_account += i[0]
	
	
	for ind in indices:
		_total_account += rank_order[str(ind["rank"])]
	_total_account *= combo
	Record.my_account = Record.my_account + _total_account

	
	combo = 1
	indices.clear()
	
	hand = deal_hand(deck)
	
	Deck.text = str(deck.size()) + " карт"
	My_Account.text = str(Record.my_account) + " очков"
	
	$ColorRect/Card_1.position.y = 400
	$ColorRect/Card_2.position.y = 400
	$ColorRect/Card_3.position.y = 400
	$ColorRect/Card_4.position.y = 400
	$ColorRect/Card_5.position.y = 400
	$ColorRect/Card_6.position.y = 400
	$ColorRect/Card_7.position.y = 400
	
	var card_1_texture = load("res://texturecards/"+str(hand[0]["imgcard"])+".png")
	var card_2_texture = load("res://texturecards/"+str(hand[1]["imgcard"])+".png")
	var card_3_texture = load("res://texturecards/"+str(hand[2]["imgcard"])+".png")
	var card_4_texture = load("res://texturecards/"+str(hand[3]["imgcard"])+".png")
	var card_5_texture = load("res://texturecards/"+str(hand[4]["imgcard"])+".png")
	var card_6_texture = load("res://texturecards/"+str(hand[5]["imgcard"])+".png")
	var card_7_texture = load("res://texturecards/"+str(hand[6]["imgcard"])+".png")
	
	Card_1.texture_normal = card_1_texture
	Card_2.texture_normal = card_2_texture
	Card_3.texture_normal = card_3_texture
	Card_4.texture_normal = card_4_texture
	Card_5.texture_normal = card_5_texture
	Card_6.texture_normal = card_6_texture
	Card_7.texture_normal = card_7_texture
	
	Move.text = str(move) + " хода"
	
	
	if move < 1:
		Record.money += 4
		get_tree().change_scene_to_file("res://store.tscn")

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
	
	$ColorRect/Card_1.position.y = 400
	$ColorRect/Card_2.position.y = 400
	$ColorRect/Card_3.position.y = 400
	$ColorRect/Card_4.position.y = 400
	$ColorRect/Card_5.position.y = 400
	$ColorRect/Card_6.position.y = 400
	$ColorRect/Card_7.position.y = 400
	
	var card_1_texture = load("res://texturecards/"+str(hand[0]["imgcard"])+".png")
	var card_2_texture = load("res://texturecards/"+str(hand[1]["imgcard"])+".png")
	var card_3_texture = load("res://texturecards/"+str(hand[2]["imgcard"])+".png")
	var card_4_texture = load("res://texturecards/"+str(hand[3]["imgcard"])+".png")
	var card_5_texture = load("res://texturecards/"+str(hand[4]["imgcard"])+".png")
	var card_6_texture = load("res://texturecards/"+str(hand[5]["imgcard"])+".png")
	var card_7_texture = load("res://texturecards/"+str(hand[6]["imgcard"])+".png")
	
	Card_1.texture_normal = card_1_texture
	Card_2.texture_normal = card_2_texture
	Card_3.texture_normal = card_3_texture
	Card_4.texture_normal = card_4_texture
	Card_5.texture_normal = card_5_texture
	Card_6.texture_normal = card_6_texture
	Card_7.texture_normal = card_7_texture
	
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
	
	$ColorRect/Card_1.position.y = 400
	$ColorRect/Card_2.position.y = 400
	$ColorRect/Card_3.position.y = 400
	$ColorRect/Card_4.position.y = 400
	$ColorRect/Card_5.position.y = 400
	$ColorRect/Card_6.position.y = 400
	$ColorRect/Card_7.position.y = 400
	
	var card_1_texture = load("res://texturecards/"+str(hand[0]["imgcard"])+".png")
	var card_2_texture = load("res://texturecards/"+str(hand[1]["imgcard"])+".png")
	var card_3_texture = load("res://texturecards/"+str(hand[2]["imgcard"])+".png")
	var card_4_texture = load("res://texturecards/"+str(hand[3]["imgcard"])+".png")
	var card_5_texture = load("res://texturecards/"+str(hand[4]["imgcard"])+".png")
	var card_6_texture = load("res://texturecards/"+str(hand[5]["imgcard"])+".png")
	var card_7_texture = load("res://texturecards/"+str(hand[6]["imgcard"])+".png")
	
	Card_1.texture_normal = card_1_texture
	Card_2.texture_normal = card_2_texture
	Card_3.texture_normal = card_3_texture
	Card_4.texture_normal = card_4_texture
	Card_5.texture_normal = card_5_texture
	Card_6.texture_normal = card_6_texture
	Card_7.texture_normal = card_7_texture
	
	Move.text = str(move) + " хода"
	Reset.text = str(reset) + " сбросов"
	
	Deck.text = str(deck.size()) + " карт"
	My_Account.text = str(Record.my_account) + " очков"

func _if_button_pressed(button_index: int):
	match button_index:
		1:
			if card_1_pressed:
				print(hand[0]["suit"],hand[0]["rank"],hand[0]["imgcard"])
				card_1_pressed = false
				$ColorRect/Card_1.position.y += 50
				pressed -= 1
				print(pressed)
			else:
				card_1_pressed = true
				$ColorRect/Card_1.position.y -= 50
				pressed += 1
				print(pressed)
		2:
			if card_2_pressed:
				print(hand[1]["suit"],hand[1]["rank"],hand[1]["imgcard"])
				card_2_pressed = false
				$ColorRect/Card_2.position.y += 50
				pressed -= 1
				print(pressed)
			else:
				card_2_pressed = true
				$ColorRect/Card_2.position.y -= 50
				pressed += 1
				print(pressed)
		3:
			if card_3_pressed:
				print(hand[2]["suit"],hand[2]["rank"],hand[2]["imgcard"])
				card_3_pressed = false
				$ColorRect/Card_3.position.y += 50
				pressed -= 1
				print(pressed)
			else:
				card_3_pressed = true
				$ColorRect/Card_3.position.y -= 50
				pressed += 1
				print(pressed)
		4:
			if card_4_pressed:
				print(hand[3]["suit"],hand[3]["rank"],hand[3]["imgcard"])
				card_4_pressed = false
				$ColorRect/Card_4.position.y += 50
				pressed -= 1
				print(pressed)
			else:
				card_4_pressed = true
				$ColorRect/Card_4.position.y -= 50
				pressed += 1
				print(pressed)
		5:
			if card_5_pressed:
				print(hand[4]["suit"],hand[4]["rank"],hand[4]["imgcard"])
				card_5_pressed = false
				$ColorRect/Card_5.position.y += 50
				pressed -= 1
				print(pressed)
			else:
				card_5_pressed = true
				$ColorRect/Card_5.position.y -= 50
				pressed += 1
				print(pressed)
		6:
			if card_6_pressed:
				print(hand[5]["suit"],hand[5]["rank"],hand[5]["imgcard"])
				card_6_pressed = false
				$ColorRect/Card_6.position.y += 50
				pressed -= 1
				print(pressed)
			else:
				card_6_pressed = true
				$ColorRect/Card_6.position.y -= 50
				pressed += 1
				print(pressed)
		7:
			if card_7_pressed:
				print(hand[6]["suit"],hand[6]["rank"],hand[6]["imgcard"])
				card_7_pressed = false
				$ColorRect/Card_7.position.y += 50
				pressed -= 1
				print(pressed)
			else:
				card_7_pressed = true
				$ColorRect/Card_7.position.y -= 50
				pressed += 1
				print(pressed)
		8:
			move_cards()
			
		9:
			replace_cards()
