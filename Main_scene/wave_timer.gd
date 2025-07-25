extends Timer

@onready var timer_label: Label = %timer_label
@onready var wave_cleared_label: Label = $"../UI/wave_cleared_label"


signal end_wave

var wave_cleared:= false

func _process(delta: float) -> void:
	timer_label.text = "%d:%02d" % [floor(time_left / 60), int(time_left) % 60]


func _on_asteroid_manager_start_timer(seconds: int, variant: String) -> void:
	start(seconds)
	if variant == "pause":
		return
	elif variant == "wave":
		wave_cleared = false
		await timeout
		if wave_cleared:
			return
		emit_signal("end_wave")


func _on_wave_cleared() -> void:
	stop()
	wave_cleared = true
	wave_cleared_label.show()
	emit_signal("end_wave")
