extends "res://Scripts/Engine.gd"
#class_name Player

# cache the anims
onready var AnimationPlayer = get_node("AnimationPlayer")

const TYPE = "PLAYER"

onready var javelin = preload("res://Scenes/Javelin.tscn")
var new_javelin

func _ready():
	change_state(IDLE_NAKED)
func _process(delta):
	if new_anim != anim:
		anim = new_anim
		AnimationPlayer.play(anim)

func _physics_process(delta):
	gravity_loop(delta)
	control_loop()
	
func _hit(dir):
	print("hit")
	hitstun = 1
	knock_dir = (position - dir).normalized()
	knock_dir.y = -4
	change_state(DAMAGED)

func _shoot():
	new_javelin = javelin.instance()
	add_child(new_javelin)