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
	[1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	#[0,0,0,0,0,1,0,0,0,1,0,0,0,0,0],
	#[0,1,1,1,1,1,0,1,1,1,0,0,0,0,1],
	#[0,1,0,0,0,0,0,1,0,1,0,1,0,0,0],
	#[0,0,0,1,1,1,1,1,1,1,0,0,0,0,0],
	#[0,1,1,1,1,1,0,1,1,1,0,0,0,0,1],
	#[0,1,0,0,0,1,0,1,0,1,1,1,0,0,0],
	#[0,1,0,0,0,1,0,1,0,1,1,1,0,0,0]
	]
	
var maze2 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

func generateMaze():
	
	
	
	#for i in range(maze.size()/2):
	
	var cellRow = generateFirstRow()
	
	for i in range(36):
		cellRow = generateRow(cellRow)
	
	cellRow = generateLastRow(cellRow) 
	
	
	for i in range(maze.size()):
		maze[i].insert(0, 1)
		maze[i].append(1)
	
	maze.append([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1])
	
	
	#for i in range(maze.size()):
	#	print(maze[i])
	return

func generateFirstRow():
	var rng = RandomNumberGenerator.new()
	var sets = []
	var cellRow = [1,  2,  3,  4,  5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
	var wallRow = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	var maxSetNum = 18
	
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
	
	sets.append([startIndex, cellRow.size()-1])
	
	#Skapa väggar neråt som andra rad
	var wallRow2 = wallRow.duplicate(true)
	for i in range(sets.size()):
		var set = sets[i]
		var max_walls = set[1] - set[0]
		var num_walls = max_walls
		#print(max_walls)
		#print(num_walls)
		var intermidiate_array = range(set[0], set[1])
		
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

func generateRow(prev_cellRow):
	var rng = RandomNumberGenerator.new()
	var sets = []
	#var cellRow = [1,  2,  3,  4,  5]
	var cellRow2 = prev_cellRow.duplicate(true)
	var prevDownWalls = maze.back()
	var rightWalls = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	
	var maxSetNum = 18
	
	var startIndex = 0
	var endIndex = 0
	
	for i in range(prev_cellRow.size()):
		if prevDownWalls[2*i] == 1:
			maxSetNum += 1
			cellRow2[i] = maxSetNum
	
	for i in range(prev_cellRow.size() - 1):
		var isWall = rng.randf_range(0.0, 1.0)
		var cell1 = cellRow2[i]
		var cell2 = cellRow2[i + 1]
		if cell1 == cell2:
			#rightWalls[2*i + 1] = 1
			isWall = 1
		elif isWall > 0.5:
			rightWalls[2*i + 1] = 1
			sets.append([startIndex, i])
			startIndex = i+1
		else:
			cellRow2[i+1] = cell1
	sets.append([startIndex, cellRow2.size()-1])
	
	var downWalls = rightWalls.duplicate(true)
	#print(sets)
	for i in range(sets.size()):
		var set = sets[i]
		var max_walls = set[1] - set[0]
		var num_walls = max_walls
		#rng.randi_range(0,max_walls)
		print(max_walls)
		print(num_walls)
		var intermidiate_array = range(set[0], set[1])
		
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
	
	print(cellRow2)
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

func loadChunk(newCenter):
	
	for z in range(maze.size()):  # Loop over rows (z is the index for rows)
		for x in range(maze[z].size()):  # Loop over columns (x is the index for columns)
			if maze[z][x] == 1:
				# Create new instance at position (x, 0, z)
				var pos = Vector3((x-10), 1, (z+10))
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
				var pos = Vector3((x-10), 1, (z-10))
				inst(pos) 
	return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var charachter = $CharacterBody3D
	var pos = Vector3(charachter.position)
	
	if pos.z > 8 && !newChunkLoaded:
		#print("pos över 10")
		maze.clear()
		generateMaze()
		loadChunk(pos)
		newChunkLoaded = true
	return
	
	
