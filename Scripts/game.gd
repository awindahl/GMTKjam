extends Node

onready var level = GameController.level
onready var exit = get_node("door"+ str(level+1))

#set exit door to an "opened" sprite

func _ready():
	$Camera2D.global_position = get_node(str(level)).get_node("cameraStart").global_position
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position
	set_exit(exit)
	
#func _process(delta):
	#detect game over
	#detect pause
	#detect score update
	
func panCam():
	print("new level pos: " + str(get_node(str(level)).get_node("cameraStart").global_position))
	$Camera2D.global_position = get_node(str(level)).get_node("cameraStart").global_position

func movePlayer():
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position

func set_exit(var door):
	door.get_node("StaticBody2D").set_collision_layer(2)
	door.get_node("StaticBody2D").set_collision_mask(2)

func reset_door(var door):
	door.get_node("StaticBody2D").set_collision_layer(1)
	door.get_node("StaticBody2D").set_collision_mask(1)
	
func _on_door1_area_entered(area):
	if area.get_name() == "hitbox" and exit == $door1:
		print("you can not escape")

func _on_door2_area_entered(area):
	if area.get_name() == "hitbox" and exit == $door2:
		print("changing level")
		level = level+1
		GameController.level = level
		reset_door(exit)
		exit = get_node("door"+ str(level+1))
		set_exit(exit)
		panCam()
		movePlayer()

func _on_door3_area_entered(area):
	if area.get_name() == "hitbox" and exit == $door3:
		print("changing level")
		level = level+1
		GameController.level = level
		reset_door(exit)
		exit = get_node("door"+ str(level+1))
		set_exit(exit)
		panCam()
		movePlayer()

func _on_door4_area_entered(area):
	if area.get_name() == "hitbox" and exit == $door4:
		print("you win!")
