extends Node2D

@onready var ui: Control = $UI
@onready var pause_menu: Control = $CanvasLayer/Pause_menu
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var options_menu: Control = $CanvasLayer/options_menu


var paused := false
var run_ended := false
var options_on := false


func _ready() -> void:
	audio_stream_player_2d.playing = true
	options_menu.initialize()


func _unhandled_input(event: InputEvent) -> void:
	if options_on:
		return
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		pause()


func start_game():
	get_tree().reload_current_scene()


func pause():
	if run_ended:
		return
	if paused:
		paused = false
		get_tree().paused = false
		pause_menu.hide()
	else:
		paused = true
		get_tree().paused = true
		pause_menu.show()
	


func _on_ship_ship_died() -> void:
	game_over(false)


func game_over(won: bool):
	$UI/wave_cleared_label.hide()
	run_ended = true
	
	get_tree().paused = true
	ui.game_over_ui(won)



func _on_play_again_button_pressed() -> void:
	get_tree().paused = false
	start_game()


func _on_audio_stream_player_2d_finished() -> void:
	audio_stream_player_2d.playing = true




func _on_options_button_pressed() -> void:
	options_on = true
	options_menu.show()


func _on_options_menu_return_buttom_pressed() -> void:
	options_on = false
	options_menu.hide()
