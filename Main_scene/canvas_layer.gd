extends CanvasLayer

@onready var points_label: Label = $points_label
var cur_points:= 0


func _ready() -> void:
	pass # Replace with function body.



func _on_asteroid_manager_points_gained(points: Variant) -> void:
	cur_points += points
	points_label.text = str(cur_points)
