extends "res://Scripts/Engine.gd"
class_name Player

# cache the anims
onready var AnimationPlayer = get_node("AnimationPlayer")

const TYPE = "PLAYER"

func _ready():
	change_state(IDLE_NAKED)
	VariableSingleton.player = self

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
	