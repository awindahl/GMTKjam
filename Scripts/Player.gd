extends "res://Scripts/Engine.gd"
class_name Player

# cache the anims
onready var AnimationPlayer = get_node("AnimationPlayer")

const TYPE = "PLAYER"

onready var javelin = preload("res://Scenes/Javelin.tscn")
onready var bomb = preload("res://Scenes/Bomb.tscn")

var new_bomb
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
	hitstun = 1
	knock_dir = (position - dir).normalized()
	knock_dir.y = -4
	change_state(DAMAGED)
	get_parent().gameOver()

func _shoot():
	new_javelin = javelin.instance()
	get_parent().add_child(new_javelin)
	
func _bomb():
	new_bomb = bomb.instance()
	get_parent().add_child(new_bomb)

func _reset():
	change_state(IDLE_NAKED)
	hitstun = 0
