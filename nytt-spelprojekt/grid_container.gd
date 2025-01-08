extends GridContainer


@onready var viewport1: SubViewport = $SubViewportContainer/SubViewport
@onready var Camera1: Camera3D = get_node("../CharacterBody3D/Neck/Camera3D2")


func _ready():
	var Camera_rid1 = Camera1.get_camera_rid()
	var viewport_rid1 = viewport1.get_viewport_rid()
	RenderingServer.viewport_attach_camera(viewport_rid1, Camera_rid1)
