extends CharacterBody2D


const SPEED = 32


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("UP"):
		move_up()
	if event.is_action_pressed("DOWN"):
		move_down()
	if event.is_action_pressed("LEFT"):
		move_left()
	if event.is_action_pressed("RIGHT"):
		move_right()
	
	
	
	if event.is_action_pressed("ESC"):
		pause_menu()



func pause_menu():
	get_tree().quit()



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
