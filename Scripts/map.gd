extends Node

onready var level = GameController.level
onready var playerEntity = $player
var xDone = false
var yDone = false
var tempX
var tempY

func _ready():
	menuMusic.get_node("menuMusic").stop()
	playerEntity.position = get_node(str(level-1)).position
	tempX = playerEntity.position.x - get_node(str(level)).position.x
	tempY = playerEntity.position.y - get_node(str(level)).position.y
	$Button.grab_focus()

func _process(delta):
	#wait 1-2 sec
	if not xDone:
		if tempX < 1 && tempX > -1:
			xDone = true
		elif tempX < 1:
			playerEntity.position.x = playerEntity.position.x + 1
		elif tempX > -1:
			playerEntity.position.x = playerEntity.position.x - 1
		tempX = playerEntity.position.x - get_node(str(level)).position.x
	if not yDone:
		if tempY < 1 && tempY > -1:
			yDone = true
		elif tempY < 1:
			playerEntity.position.y = playerEntity.position.y + 1
		elif tempY > -1:
			playerEntity.position.y = playerEntity.position.y - 1
		tempY = playerEntity.position.y - get_node(str(level)).position.y
	#wait 1-2 sec
	if yDone and xDone:
		transition.fade_to("res://Scenes/game.tscn", 0.9)

func _on_Button_pressed():
	transition.fade_to("res://Scenes/game.tscn", 0.9)
