extends RigidBody2D

@onready var detector: Area2D = $detector


func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullets"):
		destroy()
		body.kill()
	elif body.is_in_group("ship"):
		body.damage()


func destroy():
	print("asteroid: boom")
	queue_free()
