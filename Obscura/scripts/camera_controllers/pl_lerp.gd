class_name PL_Lerp
extends CameraControllerBase

@export var follow_speed:float = 1
@export var catchup_speed:float = 8
@export var leash_distance:float = 25

func _ready() -> void:
	super()
	position = target.position

func _process(delta: float) -> void:
	if !current: 
		return 
		
	var distance = global_position.distance_to(target.global_position)
	
	if distance >= leash_distance: # When the distance is move than the leash distance, it will lerp to target with catchup_speed
		global_position = global_position.lerp(target.global_position, catchup_speed * delta)
	else: # When the distance is less than leash, it will lerp to target with follow_speed
		global_position = global_position.lerp(target.global_position, follow_speed * delta)
		
	super(delta)
	
	if draw_camera_logic:
		draw_logic()
		
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	immediate_mesh.surface_add_vertex(Vector3(-2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(2.5, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 2.5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -2.5))

	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	await get_tree().process_frame
	mesh_instance.queue_free()
