extends Node

@onready var ship: RigidBody2D = %Ship
@onready var wave_timer: Timer = $"../wave_timer"

const asteroid_scene = preload("uid://cfk36bntcatic")

signal points_gained(points)
signal start_timer(seconds: int, variant: String)
signal game_over

@export var LEVELS: Array[Vector3i]

var cur_level := 0
var wave_duration := 30
var pause_duration := 5


func _ready() -> void:
	start_level(cur_level)


func start_level(level):
	emit_signal("start_timer", wave_duration, "wave")
	
	#spawning asteroids:
	var asteroids = LEVELS[level]
	for i in range(asteroids.x):
		spawn(0, random_spawn())
	for i in range(asteroids.y):
		spawn(1, random_spawn())
	for i in range(asteroids.z):
		spawn(2, random_spawn())


func end_level() -> void:
	#visual effect? #TODO
	for asteroid in get_children():
		asteroid.destroy()
	
	cur_level+=1
	if cur_level >= len(LEVELS):
		await get_tree().create_timer(0.5).timeout
		emit_signal("game_over")
		return
	
	
	emit_signal("start_timer", pause_duration, "pause")
	await wave_timer.timeout
	
	start_level(cur_level)


#############################################################
func random_spawn() -> Vector2:
	var valid_pos = false
	var pos: Vector2
	while !valid_pos:
		pos = Vector2(randf_range(0,1280), randf_range(0,720))
		if pos.distance_to(ship.position) >= 75: valid_pos = true
	return pos


func spawn(size, pos):
	var asteroid: Asteroid = asteroid_scene.instantiate()
	asteroid.position = pos
	asteroid.size = size
	call_deferred("add_child", asteroid)


func _on_asteroid_shooted(asteroid: Asteroid):
	var x = float(asteroid.size)
	var points = int(0.5*x*x+0.5*x+1)
	emit_signal("points_gained", points)
	split(asteroid)
	
	#TODO 1111
	#if len(get_children()) == 1:
		#end_level()


func split(asteroid: Asteroid):
	if asteroid.size == 0:
		return
	spawn(asteroid.size-1, asteroid.position)
	spawn(asteroid.size-1, asteroid.position)
	
