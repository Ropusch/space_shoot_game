extends Node


const ASTEROIDS := [preload("uid://cqiq6sj06hh84"), preload("uid://rv2wwubcmnx2"), preload("uid://bjteudg2h612t")]

signal points_gained(points)

func _ready() -> void:
	pass # Replace with function body.


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
	
