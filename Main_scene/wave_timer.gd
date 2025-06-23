extends Timer

@onready var timer_label: Label = %timer_label


signal end_wave

func _process(delta: float) -> void:
	timer_label.text = "%d:%02d" % [floor(time_left / 60), int(time_left) % 60]


func _on_asteroid_manager_start_timer(seconds: int, variant: String) -> void:
	start(seconds)
	if variant == "pause":
		return
	elif variant == "wave":
		await timeout
		emit_signal("end_wave")
		
