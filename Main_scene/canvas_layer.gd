extends Control

@onready var points_label: Label = $points_label
@onready var timer_label: Label = %timer_label
@onready var game_over_label: Label = $game_over_label
@onready var options_menu: Control = $"../CanvasLayer/options_menu"


var cur_points:= 0
var highscore : int 


func _ready() -> void:
	var data = SaveManager.load_data()
	highscore = data["highscore"]



func _on_asteroid_manager_points_gained(points: Variant) -> void:
	cur_points += points
	if cur_points > highscore:
		highscore = cur_points
	points_label.text = str(cur_points)


func game_over_ui(won: bool):
	points_label.hide()
	timer_label.hide()
	
	if won:
		game_over_label.text = "YOU WON\n\nSCORE: %d\nHIGHSCORE: %d" % [cur_points, highscore]
	else:
		game_over_label.text = "GAME OVER\n\nSCORE: %d\nHIGHSCORE: %d" % [cur_points, highscore]
	game_over_label.show()
	
	save_game()


func save_game() -> void:
	SaveManager.save_data({
		"highscore" = highscore,
		"master_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master")),
		"music_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("music")),
		"sfx_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("sfx"))
	})
	


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main_scene/menu_scenes/start_menu.tscn")
