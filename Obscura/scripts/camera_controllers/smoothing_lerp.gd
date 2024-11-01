class_name SmoothingLerp
extends CameraControllerBase

var lead_speed: float = 2
var catchup_delay_duration: float = 0.5
var catchup_speed: float = 2
var leash_distance: float = 5

var timer: float = 0.0

func _ready() -> void:
	super()
	position = target.position

func _process(delta: float) -> void:
	if !current:
		return
		
	global_position += target.velocity * delta
	
	if target.velocity != Vector3(0, 0, 0): 
		timer = 0.0 # When the target starts moving, the timer resets
		var direction = target.velocity.normalized()
		# Lerp global_position to an offset of the target
		global_position = global_position.lerp(target.global_position + (direction * leash_distance),  lead_speed * delta)
	else:
		timer += delta # When the target stops moving, time will be added to the timer and global position will lerp to target
		if timer >= catchup_delay_duration:
			global_position = global_position.lerp(target.global_position, catchup_speed * delta)
			
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
