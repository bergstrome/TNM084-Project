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
var newChunkLoaded = false

var maze = [
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
	[1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
	[1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1],
	[1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1],
	[1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1],
	[1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1],
	[1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1],
	[1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1],
	[1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1],
	[1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1],
	[1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1],
	[1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
	[1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1],
	[1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
]

var hedge = preload("res://hedge.tscn")

func loadChunk(newCenter):
	
	for z in range(maze.size()):  # Loop over rows (z is the index for rows)
		for x in range(maze[z].size()):  # Loop over columns (x is the index for columns)
			if maze[z][x] == 1:
				# Create new instance at position (x, 0, z)
				var pos = Vector3((x-10), 1, (z+10))
				inst(pos) 
	return
	
	return

func inst(pos):
	var instance = hedge.instantiate()
	instance.position = pos
	add_child(instance)
	return
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
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
	
	
