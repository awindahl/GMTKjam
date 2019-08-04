extends Node

var paused = false
var gameOverBool = false
onready var pauseHud = $pause
onready var pauseLabel = $pauseLabel
onready var floorNr = $floorNr
onready var scoreNr = $scoreNr
onready var fist = $equipFist
onready var sword = $equipSword
onready var javelin = $equipJavelin
onready var bomb = $equipBomb
onready var gameOver = $gameOver

func _ready():
	equip("UNARMED")

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			_on_quitBtn_pressed()
		if event.pressed and event.scancode == KEY_P:
			_on_pauseBtn_pressed()
		if event.pressed and event.scancode == KEY_R:
			_on_restartBtn_pressed()

func _on_quitBtn_pressed():
	GameController.coinSpawner = []
	GameController.enemy = []
	transition.fade_to("res://Scenes/Menu/MainMenu.tscn", 0.9)

func _on_pauseBtn_pressed():
	if not gameOverBool:
		if not paused:
			get_tree().set_pause(true)
			pauseHud.show()
			pauseLabel.show()
			paused = true
		else:
			get_tree().set_pause(false)
			pauseHud.hide()
			pauseLabel.hide()
			paused = false

func _on_restartBtn_pressed():
	if gameOverBool:
		restart()
	if not paused:
		get_parent().get_parent().restartLevel()

func gameOver():
	gameOverBool = true
	pauseHud.show()
	gameOver.show()

func restart():
	pauseHud.hide()
	gameOver.hide()
	gameOverBool = false
	equip("unarmed")

func equip(var type):
	fist.hide()
	sword.hide()
	javelin.hide()
	bomb.hide()
	match type:
		"UNARMED":
			fist.show()
		"SWORD":
			sword.show()
		"JAVELIN":
			javelin.show()
		"BOMB":
			bomb.show()

func addScore(var num):
	scoreNr.text = str(int(scoreNr.text) + num)

func updateScore(var num):
	scoreNr.text = str(num)
	
func addLevel(var num):
	floorNr.text = str(int(floorNr.text) + num)
