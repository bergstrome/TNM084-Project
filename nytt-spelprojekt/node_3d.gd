extends Node3D

#var maze = [
	#[1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	#[1, 0, 1, 0, 0, 0, 0, 0, 0, 0],
	#[1, 0, 1, 1, 1, 1, 1, 0, 1, 1],
	#[1, 0, 1, 0, 0, 0, 1, 0, 0, 0],
	#[1, 0, 1, 0, 1, 0, 1, 1, 1, 0],
	#[1, 0, 0, 0, 1, 0, 0, 0, 1, 0],
	#[1, 1, 1, 1, 1, 1, 1, 0, 1, 0],
	#[1, 0, 0, 0, 0, 0, 0, 0, 1, 0],
	#[1, 0, 1, 1, 1, 1, 1, 1, 1, 0],
	#[1, 0, 0, 0, 0, 0, 1, 0, 1, 0],
#]

#var maze = [
	#[1, 1] ,
	#[1, 0]
#
#]
var newChunkLoaded = false

#var maze = [
	#[1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	#[1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
	#[1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
	#[1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1],
	#[1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1],
	#[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1],
	#[1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1],
	#[1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1],
	#[1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1],
	#[1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1],
	#[1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1],
	#[1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1],
	#[1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1],
	#[1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1],
	#[1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
	#[1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1],
	#[1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1],
	#[1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1],
	#[1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	#[1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
#]

var maze = [
	]
	
var maze2 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

var maze_length_x = 0
var maze_length_z = 0

func generateMaze():
	
	maze.clear()
	
	maze.append([1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1])
	#for i in range(maze.size()/2):
	
	var cellRow = generateFirstRow()
	#print(cellRow)
	
	for i in range(10):
		cellRow = generateRow(cellRow)
		#print(cellRow)
	cellRow = generateLastRow(cellRow) 
	#print(cellRow)
	
	for i in range(maze.size()):
		maze[i].insert(0, 1)
		maze[i].append(1)
	
	maze.append([1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1])
	maze_length_x = maze[0].size()-1
	maze_length_z = maze.size()-1
	
	maze[11][0] = 0
	maze[11][maze[11].size()-1] = 0
	
	return

func generateFirstRow():
	var rng = RandomNumberGenerator.new()
	var sets = []
	var cellRow = [1,  2,  3,  4,  5, 6, 7, 8, 9]
	var wallRow = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	var maxSetNum = 9
	
	var startIndex = 0
	var endIndex = 0
	
	#Skapa höger väggar för första raden
	for i in range(cellRow.size() - 1):
		var isWall = rng.randf_range(0.0, 1.0)
		var cell1 = cellRow[i]
		var cell2 = cellRow[i + 1]
		if isWall > 0.5:
			
			wallRow[2*i + 1] = 1
			sets.append([startIndex, i])
			startIndex = i+1
		else:
			cellRow[i+1] = cell1
			endIndex = i+1
	if cellRow[0] != cellRow[cellRow.size()-1]:
		sets.append([startIndex, cellRow.size()-1])
	
	#Skapa väggar neråt som andra rad
	var wallRow2 = wallRow.duplicate(true)
	for i in range(sets.size()):
		var set = sets[i]
		var max_walls = set[1] - set[0]
		var num_walls = rng.randi_range(max_walls,max_walls)
		#print(num_walls)
		#print(max_walls)
		#print(num_walls)
		var intermidiate_array = range(set[0], set[1] + 1)
		
		for j in range(0, num_walls):
			var index = rng.randi_range(0,intermidiate_array.size()-1)
			if 2*intermidiate_array[index]-1 > 0:
				wallRow2[2*intermidiate_array[index]-1] = 1
			wallRow2[2*intermidiate_array[index]] = 1
			if 2*intermidiate_array[index]+1 < wallRow2.size() - 1:
				wallRow2[2*intermidiate_array[index]+1] = 1
			intermidiate_array.remove_at(index)
			
	maze.append(wallRow)
	maze.append(wallRow2)
	return cellRow
var maxSetNum = 9
func generateRow(prev_cellRow):
	var rng = RandomNumberGenerator.new()
	var sets = []
	#var cellRow = [1,  2,  3,  4,  5]
	var cellRow2 = prev_cellRow.duplicate(true)
	var prevDownWalls = maze.back()
	var rightWalls = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	
	
	
	var startIndex = 0
	var endIndex = 0
	
	for i in range(prev_cellRow.size()):
		if prevDownWalls[2*i] == 1:
			maxSetNum += 1
			cellRow2[i] = maxSetNum
	
	for i in range(prev_cellRow.size() - 1):
		var same_set = false
		var isWall = rng.randf_range(0.0, 1.0)
		var cell1 = cellRow2[i]
		var cell2 = cellRow2[i + 1]
		if cell1 == cell2:
			#rightWalls[2*i + 1] = 1
			isWall = 1
			same_set = true
		if isWall > 0.5:
			maze.back()[2*i + 1] = 1
			rightWalls[2*i + 1] = 1
			#Skall inte lägga till ifall setet redan finns
			if !same_set || sets.size() == 0:
				sets.append([startIndex, i])
				startIndex = i+1
		else:
			if cell1 < cell2:
				cellRow2[i+1] = cell1
			else:
				cellRow2[i] = cell2
			
	if cellRow2[0] != cellRow2[cellRow2.size()-1]:
		sets.append([startIndex, cellRow2.size()-1])
	
	var downWalls = rightWalls.duplicate(true)
	#print(sets)
	for i in range(sets.size()):
		var set = sets[i]
		var max_walls = set[1] - set[0]
		var num_walls = rng.randi_range(max_walls,max_walls)
		#print(num_walls)
		var intermidiate_array = range(set[0], set[1] + 1)
		
		for j in range(0, num_walls):
			var index = rng.randi_range(0,intermidiate_array.size()-1)
			if 2*intermidiate_array[index]-1 > 0:
				downWalls[2*intermidiate_array[index]-1] = 1
			downWalls[2*intermidiate_array[index]] = 1
			if 2*intermidiate_array[index]+1 < downWalls.size()-1:
				downWalls[2*intermidiate_array[index]+1] = 1
			intermidiate_array.remove_at(index)
	
	maze.append(rightWalls)
	maze.append(downWalls)
	
	#print(sets)
	
	return cellRow2
	
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

var hedge = preload("res://hedge2.tscn")

func load_chunk(center):
	
	for z in range(maze.size()):  # Loop over rows (z is the index for rows)
		for x in range(maze[z].size()):  # Loop over columns (x is the index for columns)
			if maze[z][x] == 1:
				# Create new instance at position (x, 0, z)
				var pos = Vector3(Vector3(x-maze_length_x/2+maze_center[0], 1, z-maze_length_z/2+maze_center[2]))
				inst(pos) 
	return

func inst(pos):
	var instance = hedge.instantiate()
	instance.position = pos
	add_child(instance)
	return
	
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

var maze_center = Vector3(0,0,0)
var tot_maze_generated = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var charachter = $CharacterBody3D
	var pos = Vector3(charachter.position)
	
	var old_maze_center = maze_center
	update_position(pos)
	if old_maze_center != maze_center:
		generateMaze()
		load_chunk(maze_center)
		tot_maze_generated += 1
		print(tot_maze_generated)
	
	return

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
	
	
	#print(maze_center)
	
	return maze_center
