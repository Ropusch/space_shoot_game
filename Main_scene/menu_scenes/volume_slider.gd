extends HSlider


@export var bus_name: String

var bus_index


func initialize() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value = AudioServer.get_bus_volume_linear(bus_index)



@warning_ignore("shadowed_variable_base_class")
func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index, value)
