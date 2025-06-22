extends Node2D


func _ready() -> void:
	print("gotowy")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		pause_menu()


func pause_menu():
	get_tree().quit()
