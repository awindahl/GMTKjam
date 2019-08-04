extends KinematicBody2D

var linearVel = Vector2()

func _process(delta):
	if not is_on_floor():
		linearVel.y += 1
	move_and_slide(linearVel)

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		if body.state == 3 or body.state == 7:
			linearVel.x = body.linear_vel.x * 0.3

func _on_Area2D_body_exited(body):
	if body.get("TYPE") == "PLAYER":
		linearVel.x = 0
