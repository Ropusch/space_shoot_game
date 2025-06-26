extends Control

signal return_buttom_pressed
signal initialize_sliders


func initialize() -> void:
	emit_signal("initialize_sliders")


func _on_return_button_pressed() -> void:
	var data = SaveManager.load_data()
	
	SaveManager.save_data({
		"highscore" = data["highscore"],
		"master_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master")),
		"music_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("music")),
		"sfx_volume_linear" = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("sfx"))
	})
	
	emit_signal("return_buttom_pressed")
