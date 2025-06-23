extends CanvasLayer

@onready var points_label: Label = $points_label
@onready var timer_label: Label = %timer_label
@onready var game_over_label: Label = $game_over_label


var cur_points:= 0
var highscore := 0 #TODO

func _ready() -> void:
	pass # Replace with function body.



func _on_asteroid_manager_points_gained(points: Variant) -> void:
	cur_points += points
	points_label.text = str(cur_points)


func _on_main_game_over() -> void:
	points_label.hide()
	timer_label.hide()
	
	game_over_label.text = "GAME OVER\n\nSCORE: %d\nHIGHSCORE: %d" % [cur_points, highscore]
	game_over_label.show()
