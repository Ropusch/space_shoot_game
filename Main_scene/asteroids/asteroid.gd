class_name Asteroid
extends RigidBody2D


enum Size {S, M, L}

@export var size: Size 

var rotation_speed := 0.3
var linear_speed := 30.0
var direction := Vector2(0,1)


func _ready() -> void:
	rotation_speed = randf_range(0.1,3)
	linear_speed = randf_range(20,140)
	direction = Vector2(0,1).rotated(randf_range(0, 2*PI))
	
	angular_velocity = rotation_speed
	linear_velocity = linear_speed * direction


func _physics_process(delta: float) -> void:
	space_wrap()


func space_wrap():
	if position.x < 0:
		call_deferred("set_global_position", global_position + Vector2(1280, 0))
	if position.x > 1280: 
		call_deferred("set_global_position", global_position + Vector2(-1280, 0))
	if position.y < 0: 
		call_deferred("set_global_position", global_position + Vector2(0, 720))
	if position.y > 720: 
		call_deferred("set_global_position", global_position + Vector2(0, -720))


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullets"):
		body.kill()
		destroy()
	elif body.is_in_group("ship"):
		body.collision()
		destroy()


func destroy():
	#TODO asteroid boom efects!!!
	queue_free()
