extends Control


signal return_buttom_pressed


func _on_return_button_pressed() -> void:
	emit_signal("return_buttom_pressed")
