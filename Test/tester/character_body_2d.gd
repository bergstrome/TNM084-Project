extends CharacterBody2D

@export var speed: int = 100 # Player's movement speed
@export var cell_size: int = 20 # Maze cell size

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Check player input
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Move the player
	velocity = direction.normalized() * speed
	move_and_slide()

	# Snap the position only when direction is zero (player stopped moving)
	if direction == Vector2.ZERO:
		position = position.snapped(Vector2(cell_size, cell_size))
