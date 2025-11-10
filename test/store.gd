extends Node

func _ready():
	$balance.text = str(Record.money)
	var joker1 = $joker1
	var joker2 = $joker2
	var joker3 = $joker3
	var joker4 = $joker4
	var Button32 = $Button32
	
	joker1.pressed.connect(_if_button_pressed.bind(1))
	joker2.pressed.connect(_if_button_pressed.bind(2))
	joker3.pressed.connect(_if_button_pressed.bind(3))
	joker4.pressed.connect(_if_button_pressed.bind(4))
	Button32.pressed.connect(_if_button_pressed.bind(5))

func _if_button_pressed(button_index: int):
	match button_index:
		1:
			if Record.money >= 4:
				$joker1.text = "Проданно"
				Record.money -= 4
				$balance.text = str(Record.money)
				Record.jokers.append([4,"Hearts"])
		2:
			if Record.money >= 5:
				$joker2.text = "Проданно"
				Record.money -= 5
				$balance.text = str(Record.money)
				Record.jokers.append([2,"Clubs"])
		3:
			if Record.money >= 6:
				$joker3.text = "Проданно"
				Record.money -= 6
				$balance.text = str(Record.money)
				Record.jokers.append([1,"Spades"])
		4:
			if Record.money >= 5:
				$joker4.text = "Проданно"
				Record.money -= 5
				$balance.text = str(Record.money)
				Record.jokers.append([3,"Diamonds"])
		5:
			Record.my_account = 0
			get_tree().change_scene_to_file("res://game.tscn")
