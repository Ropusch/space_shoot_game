class_name Asteroid
extends RigidBody2D

@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var line_2d: Line2D = $Line2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var asteroids_particles_2d: CPUParticles2D = $Asteroids_Particles2D


enum Size {S, M, L}

@export var size: Size 

var asteroid_polygons: Array[PackedVector2Array]  = [
	PackedVector2Array([Vector2(3, -9), Vector2(-3.0108, -7.4946), Vector2(-10, -4), Vector2(-8, 5), Vector2(1, 12), Vector2(11, 6), Vector2(10, 1), Vector2(13, -3), Vector2(8, -9), Vector2(3, -9), Vector2(-1, -8)]),
	PackedVector2Array([Vector2(-20.5, 6), Vector2(-19.5, -2), Vector2(-11.5, -9), Vector2(9.5, -14), Vector2(19.5, -9), Vector2(23.5, 4), Vector2(12.5, 7), Vector2(-2.5, 18), Vector2(-12.5, 14)]),
	PackedVector2Array([Vector2(-9, -17), Vector2(-18, -14), Vector2(-24, -8), Vector2(-18, 6), Vector2(-11, 10), Vector2(-10, 14), Vector2(-4, 25), Vector2(5, 22), Vector2(7, 15), Vector2(21, 8), Vector2(29.5238, 3.78182), Vector2(32, -9), Vector2(27, -12), Vector2(25, -17), Vector2(11, -22), Vector2(-3, -23), Vector2(-6, -20)])
]

var rotation_speed := 0.3
var linear_speed := 30.0
var direction := Vector2(0,1)


signal shooted(asteroid: Asteroid)


func _ready() -> void:
	prep()
	
	var manager = get_tree().get_first_node_in_group("asteroid_manager")
	if manager:
		shooted.connect(Callable(manager, "_on_asteroid_shooted"))
	rotation_speed = randf_range(0.1,3)
	linear_speed = randf_range(20,140)
	direction = Vector2(0,1).rotated(randf_range(0, 2*PI))
	
	angular_velocity = rotation_speed
	linear_velocity = linear_speed * direction


func prep():
	asteroids_particles_2d.emitting=false
	collision_polygon_2d.polygon = asteroid_polygons[size]
	line_2d.points = asteroid_polygons[size]
	
	#TODO particle


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
		emit_signal("shooted", self)
		destroy()
	elif body.is_in_group("ship"):
		body.collision()


func destroy():
	animation_player.play("explosion")
