extends "res://Scripts/Engine.gd"

# cache the anims
onready var AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	change_state(IDLE_NAKED)

func _process(delta):
	if new_anim != anim:
		anim = new_anim
		AnimationPlayer.play(anim)

func _physics_process(delta):
	gravity_loop(delta)
	control_loop()
	
