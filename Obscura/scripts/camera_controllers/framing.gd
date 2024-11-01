class_name Framing
extends CameraControllerBase

@export var top_left: Vector2 = Vector2(-10,10)
@export var bottom_right: Vector2 = Vector2(10,-10)
@export var autoscroll_speed: Vector3 = Vector3(1,0,1)

var left:float = top_left.x
var right:float = bottom_right.x
var top:float = top_left.y
var bottom:float = bottom_right.y

func _ready() -> void:
	super()
	position = target.position

	
func _process(delta: float) -> void:
	var tgp = target.global_position
	if !current:
		return
		
	top_left.x += autoscroll_speed.x*delta # updating scrolling position
	bottom_right.x += autoscroll_speed.x*delta 
	top_left.y += autoscroll_speed.z*delta 
	bottom_right.y += autoscroll_speed.z*delta 

	if tgp.x < top_left.x+0.5: # Calculating target position to be in box
		tgp.x = top_left.x+0.5
	if tgp.x > bottom_right.x-0.5:
		tgp.x = bottom_right.x-0.5
	if tgp.z > top_left.y-0.5:
		tgp.z = top_left.y-0.5
	if tgp.z < bottom_right.y+0.5:
		tgp.z = bottom_right.y+0.5
		
	target.global_position.x = tgp.x # Updating target position to be in box
	target.global_position.z = tgp.z

	if draw_camera_logic:
		draw_logic()
		
	position = Vector3(top_left.x + 10, 0, bottom_right.y + 10) # Sets camera to box
	super(delta)
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)

	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	
	
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	await get_tree().process_frame
	mesh_instance.queue_free()
