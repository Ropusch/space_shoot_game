extends RigidBody2D


func _physics_process(delta: float) -> void:
	if position.x <= -20 or position.x >= 1300 or position.y <= -20 or position.y >= 740:
		kill()


func kill():
	queue_free()
