extends KinematicBody2D
class_name Enemy

const CENTER = Vector2(0,0)
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)

var linearVel = Vector2(0,0)
var knockVel = Vector2(0,0)
var isSeeingPlayer = false

export var SPEED = 70

var moveDir
var moveTimer = 0
var moveTimerLength = 60
var playerPos
var player
var gonnaExplode = false
onready var myBody = get_node("CollisionShape2D")
onready var animationPlayer = get_node("AnimationPlayer")
var alive = true

func _ready():
		
	moveDir = rand()
	linearVel = moveDir.normalized()

func _process(delta):
	
	_vision()
	
	# gravity
	linearVel.y = 4
	
	if moveTimer > 0:
		moveTimer -= 1
	
	if moveTimer == 0:
		moveDir = rand()
		linearVel = moveDir.normalized()
		moveTimer = moveTimerLength

	if alive:
		if linearVel.x < 0:
			$Sprite.flip_h = true
		elif linearVel.x > 0:
			$Sprite.flip_h = false
		
		
		move_and_slide(linearVel * SPEED)
	
	elif not alive and not gonnaExplode:
		$AnimationPlayer.stop()
		$Point.visible = false
		knockVel.y += 0.1
		move_and_slide(knockVel * SPEED)
	
	print($RayCast2D.rotation_degrees)
	
	if knockVel.y > 2.5 and not alive:
		die()

func rand():
	var d = randi() % 2 + 1
	
	match d:
		1:
			return LEFT
		2:
			return RIGHT

func _vision():
	for body in $Vision.get_overlapping_bodies():
		if body.get("TYPE") == "PLAYER":
			linearVel = (position - body.position).normalized() * -1
			isSeeingPlayer = true
			$Point.visible = true
		else:
			isSeeingPlayer = false
			$Point.visible = true
		
func die():
	queue_free()

func _on_Hitbox_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		#body.get_node("HurtSound").play()
		body._hit(position)
		gonnaExplode = true
		alive = false
		animationPlayer.play("Skele_explode")
		linearVel.x = 0 

func hit(hit_pos):
	knockVel = (hit_pos - position).normalized()
	knockVel.y -= 3
	alive = false