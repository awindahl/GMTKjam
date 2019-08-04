extends KinematicBody2D

const CENTER = Vector2(0,0)
const LEFT = Vector2(-1,-1)
const RIGHT = Vector2(1,-1)
const TYPE = "ENEMY"
const ENEMY = "SLIME"

var moveDir
var moveTimer = 0
var alive = true
var moveTimerLength = 60
var isJumping = false
var javelin = preload("res://Scenes/JavelinPickup.tscn")

export var SPEED = 250

var linearVel = Vector2()
var knockDir = Vector2()

func _process(delta):
	
		# gravity
	if not $RayCast2D.is_colliding():
		linearVel.y += 1
	
	if moveTimer > 0 and $RayCast2D.is_colliding():
		moveTimer -= 1
	
	if moveTimer == 0 and $RayCast2D.is_colliding() and not isJumping:
		isJumping = true
		moveDir = rand()
		linearVel = moveDir.normalized()
		moveTimer = moveTimerLength
		$Sprite.frame = 2
	elif $RayCast2D.is_colliding() and $Sprite.frame == 2:
		isJumping = false
		$Sprite.frame = 1
	elif $Sprite.frame == 1 and $RayCast2D.is_colliding():
		$Sprite.frame = 0

	if alive and $Sprite.frame == 2:
		if linearVel.x < 0:
			$Sprite.flip_h = false
		elif linearVel.x > 0:
			$Sprite.flip_h = true
		move_and_slide(linearVel * SPEED)
	elif not alive:
		knockDir.y += 0.1
		move_and_slide(knockDir * SPEED)
	
	if not alive and $RayCast2D.is_colliding() and knockDir.y > 2:
		die()

func rand():
	var d = randi() % 2 + 1
	
	match d:
		1:
			return LEFT
		2:
			return RIGHT

func hit(hit_pos):
	knockDir = (hit_pos - position).normalized()
	knockDir.y -= 2
	alive = false

func die():
	var newJavelin = javelin.instance()
	newJavelin.position = position
	get_parent().add_child(newJavelin)
	queue_free()