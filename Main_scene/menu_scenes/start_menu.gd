extends Control


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var options_menu: Control = $options_menu

const main_scene_path = "res://Main_scene/main.tscn"


func _ready() -> void:
	audio_stream_player_2d.playing = true


func _on_play_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(main_scene_path)


func _on_options_button_pressed() -> void:
	options_menu.show()


func _on_options_menu_return_buttom_pressed() -> void:
	options_menu.hide()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_audio_stream_player_2d_finished() -> void:
	audio_stream_player_2d.playing = true
