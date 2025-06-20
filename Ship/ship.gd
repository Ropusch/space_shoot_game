extends CharacterBody2D

const BULLET = preload("uid://dlixkppfvsxrk")

const SPEED = 32


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("UP"):
		move_up()
		shot(PI)
	if event.is_action_pressed("DOWN"):
		move_down()
		shot(0)
	if event.is_action_pressed("LEFT"):
		move_left()
		shot(PI/2)
	if event.is_action_pressed("RIGHT"):
		move_right()
		shot(3*PI/2)
	
	
	
	if event.is_action_pressed("ESC"):
		pause_menu()



func pause_menu():
	get_tree().quit()


func shot(angle: float):
	var bullet = BULLET.instantiate()
	add_child(bullet)
	bullet.rotation = angle
	bullet.global_position = position

	var speed = 500.0  
	var direction = Vector2(0,-1).rotated(angle)  
	bullet.linear_velocity = direction * speed


func move_up() -> void:
	position.y -= SPEED
	if position.y <= 0:
		position.y += 640

func move_down() -> void:
	position.y += SPEED
	if position.y >= 640:
		position.y -= 640

func move_left() -> void:
	position.x -= SPEED
	if position.x <= 0:
		position.x += 640

func move_right() -> void:
	position.x += SPEED
	if position.x >= 640:
		position.x -= 640
