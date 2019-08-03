extends KinematicBody2D
class_name Enemy

const CENTER = Vector2(0,0)
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)

var linearVel = Vector2(0,0)
var isSeeingPlayer = false

export var SPEED = 70

var moveDir
var moveTimer = 0
var moveTimerLength = 60
var playerPos
var player
onready var myBody = get_node("CollisionShape2D")
var alive = true

func _ready():
		
	moveDir = rand()
	linearVel = moveDir.normalized()

func _process(delta):
	
	_vision()
	
	print(linearVel)
	# gravity
	linearVel.y = 4
	
	if moveTimer > 0:
		moveTimer -= 1
	
	if moveTimer == 0:
		moveDir = rand()
		linearVel = moveDir.normalized()
		moveTimer = moveTimerLength

	if alive:
		if linearVel.x < 2:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
		
		move_and_slide(linearVel * SPEED)
	

func _on_HitBox_body_entered(body):
	if body is Player:
			body.get_node("HurtSound").play()
			body._hit()

func rand():
	var d = randi() % 2 + 1
	
	match d:
		1:
			return LEFT
		2:
			return RIGHT

func _vision():
	for body in $Vision.get_overlapping_bodies():
		if body is Player:
			linearVel = (position - body.position).normalized() * -1
			isSeeingPlayer = true
			$Point.visible = true
		else:
			isSeeingPlayer = false
			$Point.visible = true