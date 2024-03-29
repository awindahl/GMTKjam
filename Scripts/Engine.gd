extends KinematicBody2D

# shared constants
const GRAVITY_VEC = Vector2(0, 500)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 1.0

# animation states
enum {IDLE_NAKED, IDLE_ARMED, RUN_NAKED, RUN_ARMED, ATTACK_DOWN, ATTACK_UP, ATTACK_FORWARD, 
		PUSH, DAMAGED, CROUCH, CROUCH_ATTACK, PICKUP, JUMP_NAKED, JUMP_ARMED, ATTACK_JAVELIN, 
		ATTACK_BOMB}

# shared variables
var linear_vel = Vector2()
var knock_dir = Vector2()
var hitstun = 0
var state
var anim
var new_anim
var attacking
var attack_timer = 0
var ammo = 0
var bombs = 0
var facing = 'right'

# player variables
export var WALK_SPEED = 45
export var JUMP_SPEED = 150
export var armed = false

# FSM
func change_state(new_state):
	state = new_state
	match state:
		IDLE_NAKED:
			new_anim = 'idle_naked'
		IDLE_ARMED:
			new_anim = 'idle_armed'
		RUN_NAKED:
			new_anim = 'run_naked'
		RUN_ARMED:
			new_anim = 'run_armed'
		ATTACK_DOWN:
			new_anim = 'attack_down'
		ATTACK_UP:
			new_anim = 'attack_up'
		ATTACK_FORWARD:
			new_anim = 'attack_forward'
		PUSH:
			new_anim = 'push'
		DAMAGED:
			new_anim = 'damaged'
		CROUCH:
			new_anim = 'crouch'
		CROUCH_ATTACK:
			new_anim = 'crouch_attack'
		PICKUP:
			new_anim = 'pickup'
		JUMP_NAKED:
			new_anim = 'jump_naked'
		JUMP_ARMED:
			new_anim = 'jump_armed'
		ATTACK_JAVELIN:
			new_anim = 'attack_javelin'
		ATTACK_BOMB:
			new_anim = 'attack_bomb'

# Non-newtonian gravity function based on a gravity vector
func gravity_loop(delta):
	linear_vel += delta * GRAVITY_VEC
	#knock_dir += delta * GRAVITY_VEC

# Player only loop
func control_loop():
	""" Control variables """
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var JUMP = Input.is_action_just_pressed("ui_accept")
	
	if attack_timer > 0:
		attack_timer -= 1
	
	""" Makes sure the player can only be controlled while not taking damage """
	if hitstun == 0:
		
		""" Checks whether or not the player has been armed """
		if armed:
			#if is_on_floor():
				""" State and sprite direction is changed based on what 
					direction is pressed if the player does not have any 
					velocity in the x-axis, the state changes to IDLE """
				linear_vel.x = -int(LEFT) + int(RIGHT)
				
				if linear_vel.x == 0 and attack_timer == 0:
					change_state(IDLE_ARMED)
					
				if LEFT and !RIGHT and !DOWN and attack_timer == 0:
					change_state(RUN_ARMED)
					
					if not facing == 'left':
						facing = 'left'
						self.scale.x *= -1
						
				if RIGHT and !LEFT and !DOWN and attack_timer == 0:
					change_state(RUN_ARMED)
					
					if not facing == 'right':
						facing = 'right'
						self.scale.x *= -1
					
				""" Handles crouching and crouch attacking """
				if DOWN:
					if attack_timer == 0 and is_on_floor():
						change_state(CROUCH)
						
					if Input.is_action_just_pressed("attack") and attack_timer == 0 and is_on_floor():
						menuMusic.get_node("hit").play(0)
						attack_timer = 10
						change_state(CROUCH_ATTACK)
				
				""" General attack function """
				if Input.is_action_just_pressed("attack") and attack_timer == 0 and is_on_floor():
					menuMusic.get_node("hit").play(0)
					attack_timer = 20
					change_state(ATTACK_FORWARD)
				if !DOWN and attack_timer == 0:
					linear_vel.x *= WALK_SPEED
				
				""" Makes sure the player can only jump while standing on the floor
					also changes the state to IDLE to make sure the current animation
					stops playing when "ui_accept" is pressed (but not held) """
				if Input.is_action_just_pressed("ui_accept") and attack_timer == 0 and is_on_floor():
					menuMusic.get_node("jump").play(0)
					change_state(JUMP_ARMED)
					linear_vel.y = -JUMP_SPEED
			
				if not is_on_floor():
					""" in-air attacks """
					if Input.is_action_just_pressed("attack") and attack_timer == 0 and !UP and !DOWN:
							attack_timer = 40
							change_state(ATTACK_FORWARD)
							menuMusic.get_node("hit").play(0)
					if Input.is_action_just_pressed("attack") and attack_timer == 0 and UP and !DOWN:
							attack_timer = 40
							change_state(ATTACK_UP)
							menuMusic.get_node("hit").play(0)
					if Input.is_action_just_pressed("attack") and attack_timer == 0 and !UP and DOWN:
							attack_timer = 40
							change_state(ATTACK_DOWN)
							menuMusic.get_node("hit").play(0)
				
		""" Changes the default state to IDLE """
		if !RIGHT and !LEFT and !DOWN and !UP and state == RUN_ARMED and attack_timer == 0:
			change_state(IDLE_ARMED)
				
		elif !armed:
				print(attack_timer)
			#if is_on_floor():
				""" State and sprite direction is changed based on what 
					direction is pressed if the player does not have any 
					velocity in the x-axis, the state changes to IDLE """
				linear_vel.x = -int(LEFT) + int(RIGHT)
				
				if linear_vel.x == 0 and attack_timer == 0:
					change_state(IDLE_NAKED)
					
				if LEFT and !RIGHT and attack_timer == 0:
					change_state(RUN_NAKED)
					
					if not facing == 'left':
						facing = 'left'
						self.scale.x *= -1
		
				if RIGHT and !LEFT and attack_timer == 0:
					change_state(RUN_NAKED)
					
					if not facing == 'right':
						facing = 'right'
						self.scale.x *= -1
				
				linear_vel.x *= WALK_SPEED
				
				if Input.is_action_just_pressed("attack2") and attack_timer == 0 and ammo and not RIGHT and not LEFT:
					menuMusic.get_node("hit").play(0)
					ammo -= 1
					attack_timer = 40
					change_state(ATTACK_JAVELIN)
				
				if Input.is_action_just_pressed("bomb") and attack_timer == 0 and bombs and not RIGHT and not LEFT and is_on_floor():
					menuMusic.get_node("hit").play(0)
					bombs -= 1
					attack_timer = 40
					change_state(ATTACK_BOMB)
				
				""" Makes sure the player can only jump while standing on the floor
					also changes the state to IDLE to make sure the current animation
					stops playing when "ui_accept" is pressed (but not held) """
				if Input.is_action_just_pressed("ui_accept") and is_on_floor() and attack_timer == 0:
					menuMusic.get_node("jump").play(0)
					change_state(JUMP_NAKED)
					linear_vel.y = -JUMP_SPEED
				
		""" Changes the default state to IDLE """
		if !RIGHT and !LEFT and !DOWN and state == RUN_NAKED and attack_timer == 0:
			change_state(IDLE_NAKED)
			linear_vel.x = WALK_SPEED
		
		if state != JUMP_NAKED and state != JUMP_ARMED and is_on_floor() \
				and not $Sprite/RayCast2D.is_colliding() and $Sprite/BlockCheck.is_colliding() \
				and (RIGHT or LEFT):
			change_state(PUSH)
		
		""" Linear velocity is updated to the movement function. """
		linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
		
	elif hitstun > 0:
		""" Player is knocked away from target of damage and state is changed to show that """
		change_state('damaged')
		if knock_dir.y < 10:
			knock_dir.y += 0.1
		move_and_slide(knock_dir*WALK_SPEED)
		if knock_dir.y > 3:
			knock_dir.x = 0
		
