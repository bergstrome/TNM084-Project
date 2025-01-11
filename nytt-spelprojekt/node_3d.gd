extends Node3D

var maze = []
var maze_length_x = 0
var maze_length_z = 0
var maxSetNum = 9
var maze_size = 9
var rng = RandomNumberGenerator.new()
var maze_center = Vector3(0,0,0)
var tot_maze_generated = 0
var hedge = preload("res://hedge2.tscn")

# Initiates an array of zeros, depending on the desired
# size of the maze
func vertical_row_init() -> Array:
	var vertical_row = []
	for i in range(2*maze_size-1):
		vertical_row.append(0)
	return vertical_row

# Generates the whole maze, row by row, by generating each row
# (helper functions) according to Eller's algorithm
func generateMaze() -> void:
	maze.clear()
	
	#var filler_row = vertical_row_init()
	#filler_row.fill(1)
	#filler_row[filler_row.size()/2 - 1] = 0
	#print(filler_row)
	maze.append([1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1])
	#maze.append(filler_row)
	var cellRow = generateFirstRow()
	
	for i in range(maze_size):
		cellRow = generateRow(cellRow)
	cellRow = generateLastRow(cellRow) 
	
	#maze.append(filler_row)
	for i in range(maze.size()):
		maze[i].insert(0, 1)
		maze[i].append(1)
	
	maze.append([1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1])
	maze_length_x = maze[0].size()-1
	maze_length_z = maze.size()-1
	
	maze[maze.size()/2 - 1][0] = 0
	maze[maze.size()/2- 1][maze[maze.size()/2].size()-1] = 0
	
	return

# Helper function to generate a row which has vertical walls
func create_vertical_walls(cellRow: Array,sets: Array) -> Array:
	var startIndex = 0
	var vertical_walls = vertical_row_init().duplicate(true)
	#Skapa vertikala väggar för första raden
	for i in range(cellRow.size() - 1):
		var same_set = false
		var gen_wall = rng.randf_range(0.0, 1.0)
		var cell_l = cellRow[i]
		var cell_r = cellRow[i + 1]
		if cell_l == cell_r:
			gen_wall = 1
			same_set = true
		if gen_wall > 0.5:
			maze.back()[2*i + 1] = 1
			vertical_walls[2*i + 1] = 1
			
			if !same_set:
				sets.append([startIndex, i])
				startIndex = i+1
			else:
				cellRow[i+1] = cell_l
		else:
			merge_sets(cellRow,cell_l,cell_r)
	
	if cellRow[0] != cellRow[cellRow.size()-1]:
		sets.append([startIndex, cellRow.size()-1])
	
	if sets.size() == 0:
		sets.append([0,cellRow.size()-1])
	
	return vertical_walls

# Helper function to generate a row which has horizontal walls
func create_horizontal_walls(vertical_walls: Array, sets: Array, cellRow: Array) -> Array:
	#Skapar horisontella väggar
	var horizontal_walls = vertical_walls.duplicate(true)
	#print(sets)
	sets.clear()
	var index_map = {}
	
	#ingen aning vad som sker här, tilldelar rätt index till rätt set
	############################################################################
	# Group indexes of the same element
	for i in range(cellRow.size()):
		var value = cellRow[i]
		# Check if the value is already in the dictionary
		if not index_map.has(value):
			index_map[value] = []  # Create a new list if it doesn't exist
		index_map[value].append(i)  # Append the index to the list

	# Collect all grouped indexes into sets
	for value in index_map.keys():
		sets.append(index_map[value])
	############################################################################
	
	for i in range(sets.size()):
		var set = sets[i]
		var max_walls = set.size() - 1
		var num_walls = rng.randi_range(0, max_walls)
		
		for j in range(0, num_walls):
			var index = rng.randi_range(0, set.size() - 1)
			
			if 2*set[index]-1 > 0:
				horizontal_walls[2*set[index]-1] = 1
				
			horizontal_walls[2*set[index]] = 1
			
			if 2*set[index]+1 < horizontal_walls.size() - 1:
				horizontal_walls[2*set[index]+1] = 1
			set.remove_at(index)
	
	return horizontal_walls

# Function to assign the set of each cell in set2 to set1,
# called when two sets are connected
func merge_sets(cell_row: Array, set1: int, set2: int):
	for e in range(cell_row.size()):
					if cell_row[e] == set2:
						cell_row[e] = set1

# Helper function to generate the first row
func generateFirstRow() -> Array:
	var sets = []
	var cellRow = range(1,maze_size+1)
	
	var vertical_walls = create_vertical_walls(cellRow,sets)
	var horizontal_walls = create_horizontal_walls(vertical_walls, sets, cellRow)
	
	maze.append(vertical_walls)
	maze.append(horizontal_walls)
	
	return cellRow

# Helper function to generate all rows in between the
# first and last row
func generateRow(prev_cellRow: Array) -> Array:
	var sets = []
	var cellRow = prev_cellRow.duplicate(true)
	var prevDownWalls = maze.back()
	#Skapar nya sets av de celler som har en vägg över
	for i in range(prev_cellRow.size()):
		maxSetNum += 1
		if prevDownWalls[2*i] == 1:
			cellRow[i] = maxSetNum
	
	var vertical_walls = create_vertical_walls(cellRow,sets)
	var downWalls = create_horizontal_walls(vertical_walls,sets, cellRow)

	maze.append(vertical_walls)
	maze.append(downWalls)
	
	return cellRow

# Helper function to generate the last row
func generateLastRow(prev_cellRow: Array) -> Array:
	#remove last row which is horizontal lines
	maze.pop_back()
	var cell_l
	var cell_r
	
	for i in range(prev_cellRow.size()-1):
		cell_l = prev_cellRow[i]
		cell_r = prev_cellRow[i+1]

		if cell_l != cell_r:
			maze.back()[2*i+1] = 0
			merge_sets(prev_cellRow,cell_l,cell_r)
	
	return prev_cellRow

# Reads the new generated maze and calls inst() to instantiate
# walls at desired places (all 1:s in the maze variable)
func load_chunk() -> void:
	for z in range(maze.size()):  # Loop over rows (z is the index for rows)
		for x in range(maze[z].size()):  # Loop over columns (x is the index for columns)
			if maze[z][x] == 1:
				# Create new instance at position (x, 0, z)
				var pos = Vector3(Vector3(x-maze_length_x/2+maze_center[0], 1, z-maze_length_z/2+maze_center[2]))
				inst(pos) 
	return

# Instatiates a copy of the object representing a wall
func inst(pos: Vector3) -> void:
	var instance = hedge.instantiate()
	instance.position = pos
	instance.add_to_group("Walls")
	add_child(instance)
	return

# Clears all copies of instances in the group group_name
func clear_instances(group_name: String):
	for node in get_tree().get_nodes_in_group(group_name):
		node.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	generateMaze()
	
	for z in range(maze.size()):  # Loop over rows (z is the index for rows)
		for x in range(maze[z].size()):  # Loop over columns (x is the index for columns)
			if maze[z][x] == 1:
				# Create new instance at position (x, 0, z)
				var pos = Vector3(x-maze_length_x/2, 1, z-maze_length_z/2)
				inst(pos) 
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var charachter = $CharacterBody3D
	var pos = Vector3(charachter.position)
	
	var old_maze_center = maze_center
	update_position(pos)
	if old_maze_center != maze_center:
		generateMaze()
		clear_instances("Walls")
		load_chunk()
		tot_maze_generated += 1
	
	return

# Called for each frame, updates the players position and changes
# maze_center variable if a new maze should be generated
func update_position(pos: Vector3) -> Vector3:
	var char_pos = pos
	var Lx = Vector3(0,0,0)
	var Lz = Vector3(0,0,0)
	if char_pos[0] > maze_center[0] + maze_length_x/2:
		Lx = Vector3(maze_length_x,0,0)
	elif char_pos[0] < maze_center[0] - maze_length_x/2:
		Lx = Vector3(-maze_length_x,0,0)
	if char_pos[2] > maze_center[2] + maze_length_z/2:
		Lz = Vector3(0,0,maze_length_z)
	elif char_pos[2] < maze_center[2] - maze_length_z/2:
		Lz = Vector3(0,0,-maze_length_z)
	
	maze_center += Lx + Lz
	
	return maze_center
