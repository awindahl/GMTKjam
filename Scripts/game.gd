extends Node

var gameOver = false
var localScore = 0
onready var hud = $CanvasLayer/hud 
onready var level = GameController.level
onready var player = GameController.player
onready var exit = get_node("door"+ str(level+1))

#	remember to go to Export, 
#	then the resources tab and set the export mode to 
#	Export all resources in the project to 
#	make godot include the JSON file in the build

func _ready():
	$Camera2D.global_position = get_node(str(level)).get_node("cameraStart").global_position
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position
	set_exit(exit)
	updateHudScore(GameController.score)
	updateHudLevel(GameController.level)
	spawnEntities()

func panCam():
	print("new level pos: " + str(get_node(str(level)).get_node("cameraStart").global_position))
	$Camera2D.global_position = get_node(str(level)).get_node("cameraStart").global_position

func movePlayer():
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position

func set_exit(var door):
	door.get_node("StaticBody2D").set_collision_layer(4)
	door.get_node("StaticBody2D").set_collision_mask(4)

func reset_door(var door):
	door.get_node("StaticBody2D").set_collision_layer(1)
	door.get_node("StaticBody2D").set_collision_mask(1)
	

func _on_door2_body_entered(body):
	if body.get("TYPE") == "PLAYER" and exit == $door2:
		updateLevel()

func _on_door3_body_entered(body):
	if body.get("TYPE") == "PLAYER" and exit == $door3:
		updateLevel()

func _on_door4_body_entered(body):
	if body.get("TYPE") == "PLAYER" and exit == $door4:
		updateLevel()

func updateLevel():
	removeEntities()
	GameController.score += localScore
	hud.updateScore(GameController.score)
	localScore = 0
	level = level+1
	updateHudLevel()
	player.ammo = 0
	player.bombs = 0
	player.armed = false
	hud.equip("UNARMED")
	GameController.level = level
	GameController._save()
	spawnEntities()
	reset_door(exit)
	exit = get_node("door"+ str(level+1))
	set_exit(exit)
	panCam()
	movePlayer()
	$Player._reset()

func restartLevel():
	removeEntities()
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position
	$Player._reset()
	hud.equip("UNARMED")
	if gameOver:
		gameOver = false
	localScore = 0
	hud.updateScore(GameController.score + localScore)
	spawnEntities()

func gameOver():
	gameOver = true
	hud.gameOver()

func equip(var item):
	hud.equip(item)

func updateHudScore(var num = 1):
	localScore += num;
	hud.addScore(num)
	
func updateHudLevel(var num = 1):
	hud.addLevel(num)

func removeEntities():
	for entity in GameController.coinSpawner:
		for coin in entity.get_children():
			if not str(coin.get_name()).match("Position2D"):
				coin.queue_free()
	for entity in GameController.enemy:
		for enemy in entity.get_children():
			if not str(enemy.get_name()).match("Position2D") and not str(enemy.get_name()).match("Sprite"):
				enemy.queue_free()

func spawnEntities():
	for entity in GameController.coinSpawner:
		entity._spawn()
	for entity in GameController.enemy:
		entity._spawn()
