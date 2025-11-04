extends Node

func _ready():
	var joker1 = $joker1
	var joker2 = $joker2
	var joker3 = $joker3
	
	
	joker1.pressed.connect(_if_button_pressed.bind(1))
	joker2.pressed.connect(_if_button_pressed.bind(2))
	joker3.pressed.connect(_if_button_pressed.bind(3))


func _if_button_pressed(button_index: int):
	match button_index:
		1:
			print("joker1")
		2:
			print("joker2")
		3:
			print("joker3")
