class_name FourPush
extends CameraControllerBase

@export var push_ratio:float = 2.5
@export var pushbox_top_left: Vector2 = Vector2(-10, -10)
@export var pushbox_bottom_right: Vector2 = Vector2(10, 10)
@export var speedup_zone_top_left: Vector2 = Vector2(-5, -5)
@export var speedup_zone_bottom_right: Vector2 = Vector2(5, 5)

func _ready() -> void:
	super()
	position = target.position

func _process(delta: float) -> void:
	if !current:
		return

	if draw_camera_logic:
		draw_logic()

	var tpos = target.global_position
	var cpos = global_position

	# Calculate boundaries
	var left_edge = pushbox_top_left .x
	var right_edge = pushbox_bottom_right.x
	var top_edge = pushbox_top_left .y
	var bottom_edge = pushbox_bottom_right.y
	
	# Push box implementation
	# Boundary checks
	# Left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + left_edge)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	# Right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + right_edge)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	# Top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + top_edge)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
	# Bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + bottom_edge)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges
		
	# Calculating the small square boundaries
	var left_small = speedup_zone_top_left.x
	var right_small = speedup_zone_bottom_right.x
	var top_small = speedup_zone_top_left.y
	var bottom_small = speedup_zone_bottom_right.y
	
	# When the target is moving between the big and small squares, it will move to the 
	# target direction 
	if target.velocity != Vector3(0, 0, 0):
		var diff_between_left_edges_s = (tpos.x - target.WIDTH / 2.0) - (cpos.x + left_small)
		if diff_between_left_edges_s < 0:
			global_position.x += diff_between_left_edges_s*push_ratio*delta
		# Right
		var diff_between_right_edges_s = (tpos.x + target.WIDTH / 2.0) - (cpos.x + right_small)
		if diff_between_right_edges_s > 0:
			global_position.x += diff_between_right_edges_s*push_ratio*delta
		# Top
		var diff_between_top_edges_s = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + top_small)
		if diff_between_top_edges_s < 0:
			global_position.z += diff_between_top_edges_s*push_ratio*delta
		# Bottom
		var diff_between_bottom_edges_s = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + bottom_small)
		if diff_between_bottom_edges_s > 0:
			global_position.z += diff_between_bottom_edges_s*push_ratio*delta
			
	super(delta)

func draw_logic() -> void:
	var mesh_instance = MeshInstance3D.new()
	var immediate_mesh = ImmediateMesh.new()
	var material = ORMMaterial3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	# Push box boundaries calculation
	var left = pushbox_top_left.x
	var right = pushbox_bottom_right.x
	var top = pushbox_top_left.y
	var bottom = pushbox_bottom_right.y
	
	# Small box boundaries calculation
	var left_s = speedup_zone_top_left.x
	var right_s = speedup_zone_bottom_right.x
	var top_s = speedup_zone_top_left.y
	var bottom_s = speedup_zone_bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	# Draws the push box mesh
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))

	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))

	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))

	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	
	# Draws the small box mesh
	immediate_mesh.surface_add_vertex(Vector3(right_s, 0, top_s))
	immediate_mesh.surface_add_vertex(Vector3(right_s, 0, bottom_s))

	immediate_mesh.surface_add_vertex(Vector3(right_s, 0, bottom_s))
	immediate_mesh.surface_add_vertex(Vector3(left_s, 0, bottom_s))

	immediate_mesh.surface_add_vertex(Vector3(left_s, 0, bottom_s))
	immediate_mesh.surface_add_vertex(Vector3(left_s, 0, top_s))

	immediate_mesh.surface_add_vertex(Vector3(left_s, 0, top_s))
	immediate_mesh.surface_add_vertex(Vector3(right_s, 0, top_s))
	
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	await get_tree().process_frame
	mesh_instance.queue_free()
