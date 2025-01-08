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
	[1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1],
	[1,1,1,1,1,1,1,1,1]	
]

func generateMaze():
	
	#for i in range(maze.size()/2):
	var i = 0
	var wallRows = generateFirstRow()
	maze[i] = wallRows[0]
	maze[i+1] = wallRows[1]
	
	return

func generateFirstRow():
	var rng = RandomNumberGenerator.new()
	var sets = []
	var cellRow = [1,  2,  3,  4,  5]
	var wallRow = [0,0,0,0,0,0,0,0,0]
	
	var startIndex = 0
	var endIndex = 0
	for i in range(cellRow.size() - 1):
		var isWall = rng.randf_range(0.0, 1.0)
		var cell1 = cellRow[i]
		var cell2 = cellRow[i + 1]
		if isWall > 0.6:
			wallRow[2*i + 1] = 1
			sets.append([startIndex, i])
			startIndex = i+1
		else:
			cellRow[i+1] = cell1
			endIndex = i+1
	
	sets.append([startIndex, cellRow.size()-1])
	var wallRow2 = wallRow.duplicate(true)
	
	for i in range(sets.size()):
		var set = sets[i]
		var max_walls = set[1] - set[0]
		var num_walls = rng.randi_range(0,max_walls)
		print(max_walls)
		print(num_walls)
		var intermidiate_array = range(set[0], set[1])
		
		for j in range(0, num_walls):
			var index = rng.randi_range(0,intermidiate_array.size()-1)
			wallRow2[2*intermidiate_array[index]] = 1
			intermidiate_array.remove_at(index)
	
	print(cellRow)
	print(wallRow)	
	print(wallRow2)
	print(sets)
	
	var ret = [wallRow, wallRow2]
	return ret



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
		loadChunk(pos)
		newChunkLoaded = true
	return
	
	
