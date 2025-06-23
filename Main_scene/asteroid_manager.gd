extends Node

@onready var ship: RigidBody2D = %Ship
@onready var wave_timer: Timer = $"../wave_timer"
@onready var mid_wave_timer: Timer = $"../mid_wave_timer"

const ASTEROIDS := [preload("uid://cqiq6sj06hh84"), preload("uid://rv2wwubcmnx2"), preload("uid://bjteudg2h612t")]
signal points_gained(points)
signal start_timer(seconds)

@export var LEVELS: Array[Vector3i]

var cur_level := 0


func _ready() -> void:
	start_level(cur_level)


func start_level(level):
	emit_signal("start_timer", 30)
	
	#spawning asteroids:
	var asteroids = LEVELS[level]
	for i in range(asteroids.x):
		spawn(0, random_spawn())
	for i in range(asteroids.y):
		spawn(1, random_spawn())
	for i in range(asteroids.z):
		spawn(2, random_spawn())


func end_level() -> void:
	#visual effect?
	for asteroid in get_children():
		remove_child(asteroid)
		asteroid.queue_free()
	
	if cur_level >= len(LEVELS)-1:
		return
		#KŁONIEC?
	mid_wave_timer.start(10)
	await mid_wave_timer.timeout
	
	cur_level+=1
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
	var asteroid: Asteroid = ASTEROIDS[size].instantiate()
	asteroid.position = pos
	call_deferred("add_child", asteroid)


func _on_asteroid_exploded(asteroid: Asteroid):
	var x = float(asteroid.size)
	var points = int(0.5*x*x+0.5*x+1)
	emit_signal("points_gained", points)
	split(asteroid)


func split(asteroid: Asteroid):
	if asteroid.size == 0:
		return
	spawn(asteroid.size-1, asteroid.position)
	spawn(asteroid.size-1, asteroid.position)
	
