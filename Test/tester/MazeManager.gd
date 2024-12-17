extends Node2D

@export var width: int = 100          # Number of cells horizontally
@export var cell_size: int = 20      # Size of each cell in pixels
@export var visible_rows: int = 5    # How many rows are visible on screen at a time
@export var final_row: int = 10     # The row that marks the end of the maze

var grid = []                       # Stores wall positions as line segments
var sets = []                       # Tracks connected cells for maze generation
var max_row_generated = 0           # Track the last row generated
var walls = []                      # Array to store wall colliders
var player                         # Reference to the player node

func _ready() -> void:
	player = $Player
	randomize()

	# Initialize unique sets for the first row
	for x in range(width):
		sets.append(x + 1)

	# Generate initial rows
	for i in range(visible_rows):
		generate_next_row()

	build_wall_colliders()

func _draw() -> void:
	# Visualize the walls
	for wall in grid:
		var start = Vector2(wall[0][1], wall[0][0]) * cell_size
		var end = Vector2(wall[1][1], wall[1][0]) * cell_size
		draw_line(start, end, Color.WHITE, 2)

func _process(delta: float) -> void:
	var player_row = int(player.position.y / cell_size)

	# Dynamically generate new rows if the player moves down
	if player_row + visible_rows > max_row_generated and max_row_generated < final_row:
		generate_next_row()
		build_wall_colliders()

	queue_redraw()

func generate_next_row() -> void:
	horizontal_connections(max_row_generated)

	# Check if we're at the final row
	if max_row_generated == final_row - 1:
		finalize_last_row()
	else:
		vertical_connections(max_row_generated)

	prep_next_row()
	max_row_generated += 1

func horizontal_connections(row: int) -> void:
	for x in range(width - 1):
		# Randomly decide to merge sets if they are not already merged
		if randi() % 2 == 0 and sets[x] != sets[x + 1]:
			merge_sets(sets[x], sets[x + 1])
			grid.append([[row, x], [row, x + 1]])

func vertical_connections(row: int) -> void:
	var connection = {}
	for x in range(width):
		var current_set = sets[x]
		if current_set not in connection:
			# Ensure at least one vertical connection per set
			connection[current_set] = true
			grid.append([[row, x], [row + 1, x]])
		elif randi() % 2 == 0:
			# Randomly add more vertical connections
			grid.append([[row, x], [row + 1, x]])

func finalize_last_row() -> void:
	# Merge all remaining cells horizontally in the last row
	for x in range(width - 1):
		if sets[x] != sets[x + 1]:
			merge_sets(sets[x], sets[x + 1])
			grid.append([[max_row_generated, x], [max_row_generated, x + 1]])

func prep_next_row() -> void:
	var next_sets = []
	for x in range(width):
		if not is_connected_vertically(x):
			next_sets.append(len(next_sets) + 1)  # New unique set
		else:
			next_sets.append(sets[x])
	sets = next_sets

func is_connected_vertically(x: int) -> bool:
	for wall in grid:
		if wall[0] == [max_row_generated, x] and wall[1] == [max_row_generated + 1, x]:
			return true
	return false

func merge_sets(set_a: int, set_b: int) -> void:
	for i in range(width):
		if sets[i] == set_b:
			sets[i] = set_a

func build_wall_colliders():
	# Remove old wall colliders
	for wall in walls:
		wall.queue_free()
	walls.clear()

	# Create StaticBody2D colliders for each wall
	for wall in grid:
		var start = Vector2(wall[0][1], wall[0][0]) * cell_size
		var end = Vector2(wall[1][1], wall[1][0]) * cell_size

		var wall_body = StaticBody2D.new()
		var collider = CollisionShape2D.new()
		var shape = RectangleShape2D.new()

		# Set size for the wall as a thin rectangle
		shape.size = Vector2((end - start).length(), 2)
		collider.shape = shape

		# Position the collider in the middle of the wall
		wall_body.position = (start + end) / 2.0
		wall_body.rotation = (end - start).angle()

		# Add to the scene
		wall_body.add_child(collider)
		add_child(wall_body)
		walls.append(wall_body)
