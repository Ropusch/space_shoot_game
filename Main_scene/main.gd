extends Node2D


signal game_over


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		pause_menu()


func start_game():
	get_tree().reload_current_scene()




func pause_menu():
	#get_tree().paused = true
	get_tree().quit()



func _on_ship_ship_died() -> void:
	get_tree().paused = true
	emit_signal("game_over")


func _on_play_again_button_pressed() -> void:
	get_tree().paused = false
	start_game()
