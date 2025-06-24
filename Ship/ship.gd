extends RigidBody2D

@onready var hull: Line2D = $hull
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pew_pew_player: AudioStreamPlayer2D = $pew_pew_player

const BULLET = preload("uid://dlixkppfvsxrk")

@export var SPEED : float
@export var ROT_SPEED := 0.8
@export var LIFES := 1
var cur_rotation = 0

var shoot_cooldown := 0.2  # sekundy
var shoot_timer := 0.0

@warning_ignore("unused_signal")
signal ship_died

func _physics_process(delta: float) -> void:
	if LIFES <= 0:
		return
	space_wrap()
	
	if Input.is_action_pressed("LEFT"):
		angular_velocity = -ROT_SPEED
		#rotation -= PI * ROT_SPEED * delta
	if Input.is_action_pressed("RIGHT"):
		#rotation += PI * ROT_SPEED * delta
		angular_velocity = ROT_SPEED

	shoot_timer -= delta
	if Input.is_action_pressed("SHOT") and shoot_timer <= 0:
		shot()
		shoot_timer = shoot_cooldown


func space_wrap():
	if position.x <= 0: position.x+=1280
	if position.x >= 1280: position.x-=1280
	if position.y <= 0: position.y += 720
	if position.y >= 720: position.y -= 720


func shot():
	pew_pew_player.play(0.0)
	
	var bullet = BULLET.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_rotation = rotation
	bullet.global_position = position + 30*Vector2(0,-1).rotated(rotation)  
#
	var speed = 500.0  
	var direction = Vector2(0,-1).rotated(rotation)  
	bullet.linear_velocity = direction * speed
	
	recoil()


func recoil():
	linear_velocity = Vector2(0, 1).rotated(rotation) * SPEED


func collision():
	LIFES -= 1
	if LIFES <= 0:
		$explosion_player.play(0.0)
		animation_player.play("explosion")
