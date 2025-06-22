extends RigidBody2D



func kill():
	print("bullet: boom")
	queue_free()
