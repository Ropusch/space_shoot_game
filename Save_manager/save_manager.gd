extends Node


const save_file_name := "user://save_data.json"
const default_data: Dictionary = {
	"highscore" = 0,
	"master_volume_linear" = 0.5,
	"music_volume_linear" = 1,
	"sfx_volume_linear" = 1
}


func save_data(data: Dictionary) -> void:
	var save_file := FileAccess.open(save_file_name, FileAccess.WRITE)
	var string_data := JSON.stringify(data)
	save_file.store_line(string_data)
	save_file.close()


func load_data() -> Dictionary:
	if FileAccess.file_exists(save_file_name):
		var save_file := FileAccess.open(save_file_name, FileAccess.READ)
		var json = JSON.new()
		
		var string_data := save_file.get_line()
		json.parse(string_data)
		var data: Dictionary = json.get_data()
		save_file.close()
		return data
	return default_data


func reset_data() -> void:
	save_data(default_data)
