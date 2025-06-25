extends Control

@onready var points_label: Label = $points_label
@onready var timer_label: Label = %timer_label
@onready var game_over_label: Label = $game_over_label
@onready var options_menu: Control = $"../CanvasLayer/options_menu"



var cur_points:= 0
var highscore := 0 #TODO

func _ready() -> void:
	pass # Replace with function body.



func _on_asteroid_manager_points_gained(points: Variant) -> void:
	cur_points += points
	points_label.text = str(cur_points)


func game_over_ui(won: bool):
	#TODO effects!!!?
	points_label.hide()
	timer_label.hide()
	
	if won:
		game_over_label.text = "YOU WON\n\nSCORE: %d\nHIGHSCORE: %d" % [cur_points, highscore]
	else:
		game_over_label.text = "GAME OVER\n\nSCORE: %d\nHIGHSCORE: %d" % [cur_points, highscore]
	game_over_label.show()





func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main_scene/menu_scenes/start_menu.tscn")
