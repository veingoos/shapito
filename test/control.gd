extends Control

func _ready():
	$Score.text = str(Record.my_account) + "Очков"
