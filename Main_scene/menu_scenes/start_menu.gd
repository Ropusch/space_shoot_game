extends Control


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var options_menu: Control = $options_menu
@onready var highscore_label: Label = $highscore_label
@onready var be_sure_control: Control = $be_sure_control

const main_scene_path = "res://Main_scene/main.tscn"


var highscore := 0


func _ready() -> void:
	load_save()
	
	options_menu.initialize()
	
	highscore_label.text = "HIGHSCORE  %d" %highscore
	
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


func _on_reset_highscore_button_pressed() -> void:
	be_sure_control.show()


func _on_yes_button_pressed() -> void:
	highscore = 0
	highscore_label.text = "HIGHSCORE  %d" %highscore
	save_game()
	be_sure_control.hide()


func _on_no_button_pressed() -> void:
	be_sure_control.hide()



func _exit_tree() -> void:
	save_game()




func load_save():
	var data = SaveManager.load_data()
	highscore = data["highscore"]
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), data["master_volume_linear"])
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("music"), data["music_volume_linear"])
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("sfx"), data["sfx_volume_linear"])


func save_game() -> void:
	SaveManager.save_data({
		"highscore" = highscore,
		"master_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master")),
		"music_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("music")),
		"sfx_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("sfx"))
	})
