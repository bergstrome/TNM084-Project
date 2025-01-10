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
func vertical_row_init():
	var vertical_row = []
	for i in range(2*maze_size-1):
		vertical_row.append(0)
	return vertical_row

# Generates the whole maze, row by row, by generating each row
# (helper functions) according to Eller's algorithm
func generateMaze():
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
func create_vertical_walls(cellRow,sets):
	var startIndex = 0
	var vertical_walls = vertical_row_init().duplicate(true)
	#Skapa höger väggar för första raden
	for i in range(cellRow.size() - 1):
		var same_set = false
		var isWall = rng.randf_range(0.0, 1.0)
		var cell1 = cellRow[i]
		var cell2 = cellRow[i + 1]
		if cell1 == cell2:
			isWall = 1
			same_set = true
		if isWall > 0.5:
			maze.back()[2*i + 1] = 1
			vertical_walls[2*i + 1] = 1
			#Skall inte lägga till ifall setet redan finns
			if !same_set || sets.size() == 0:
				sets.append([startIndex, i])
				startIndex = i+1
		else:
			if cell1 <= cell2:
				cellRow[i+1] = cell1
			else:
				cellRow[i] = cell2
	
	if cellRow[0] != cellRow[cellRow.size()-1]:
		sets.append([startIndex, cellRow.size()-1])
	
	return vertical_walls

# Helper function to generate a row which has horizontal walls
func create_horizontal_walls(vertical_walls, sets):
	#Skapar horisontella väggar
	var horizontal_walls = vertical_walls.duplicate(true)
	for i in range(sets.size()):
		var set = sets[i]
		var max_walls = set[1] - set[0]
		var num_walls = rng.randi_range(max_walls,max_walls)
		
		var intermidiate_array = range(set[0], set[1] + 1)
		
		for j in range(0, num_walls):
			var index = rng.randi_range(0, intermidiate_array.size() - 1)
			if 2*intermidiate_array[index]-1 > 0:
				horizontal_walls[2*intermidiate_array[index]-1] = 1
			horizontal_walls[2*intermidiate_array[index]] = 1
			if 2*intermidiate_array[index]+1 < horizontal_walls.size() - 1:
				horizontal_walls[2*intermidiate_array[index]+1] = 1
			intermidiate_array.remove_at(index)
	
	return horizontal_walls

# Helper function to generate the first row
func generateFirstRow():
	var sets = []
	var cellRow = range(1,maze_size+1)
	print(cellRow)
	
	var vertical_walls = create_vertical_walls(cellRow,sets)
	var horizontal_walls = create_horizontal_walls(vertical_walls, sets)
	
	maze.append(vertical_walls)
	maze.append(horizontal_walls)
	return cellRow

# Helper function to generate all rows in between the
# first and last row
func generateRow(prev_cellRow):
	var sets = []
	var cellRow = prev_cellRow.duplicate(true)
	var prevDownWalls = maze.back()
	
	#Skapar nya sets av de celler som har en vägg över
	for i in range(prev_cellRow.size()):
		if prevDownWalls[2*i] == 1:
			maxSetNum += 1
			cellRow[i] = maxSetNum
	
	var vertical_walls = create_vertical_walls(cellRow,sets)
	var downWalls = create_horizontal_walls(vertical_walls,sets)

	maze.append(vertical_walls)
	maze.append(downWalls)
	
	return cellRow

# Helper function to generate the last row
func generateLastRow(prev_cellRow):
	maze.pop_back()
	var cell1
	var cell2
	
	for i in range(prev_cellRow.size()-1):
		cell1 = prev_cellRow[i]
		cell2 = prev_cellRow[i+1]
		
		if cell1 != cell2:
			maze.back()[2*i+1] = 0
	
	return prev_cellRow

# Reads the new generated maze and calls inst() to instantiate
# walls at desired places (all 1:s in the maze variable)
func load_chunk():
	for z in range(maze.size()):  # Loop over rows (z is the index for rows)
		for x in range(maze[z].size()):  # Loop over columns (x is the index for columns)
			if maze[z][x] == 1:
				# Create new instance at position (x, 0, z)
				var pos = Vector3(Vector3(x-maze_length_x/2+maze_center[0], 1, z-maze_length_z/2+maze_center[2]))
				inst(pos) 
	return

# Instatiates a copy of the object representing a wall
func inst(pos):
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
		print(tot_maze_generated)
	
	return

# Called for each frame, updates the players position and changes
# maze_center variable if a new maze should be generated
func update_position(pos):
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
