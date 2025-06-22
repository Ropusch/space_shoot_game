extends RigidBody2D

@onready var hull: Line2D = $hull

const BULLET = preload("uid://dlixkppfvsxrk")

@export var SPEED = 32
var cur_rotation = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LEFT"):
		rotation -= deg_to_rad(5)
	if event.is_action_pressed("RIGHT"):
		rotation += deg_to_rad(5)
	if event.is_action_pressed("SHOT"):
		shot()


func rotate_hull(new_angle):
	hull.rotation = new_angle


func shot():
	var bullet = BULLET.instantiate()
	add_child(bullet)
	bullet.rotation = cur_rotation 
	bullet.global_position = position + 30*Vector2(0,-1).rotated(cur_rotation)  

	var speed = 500.0  
	var direction = Vector2(0,-1).rotated(cur_rotation)  
	bullet.linear_velocity = direction * speed
	
	recoil()


func recoil():
	apply_impulse(Vector2.ZERO, Vector2(0,-1).rotated(cur_rotation) * SPEED)


func damage():
	print("ship: booom :C")
