extends CharacterBody3D

class_name player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camerabase : Node3D = $CameraBase

func _enter_tree():
	print(name)
	set_multiplayer_authority(name.to_int())

func _ready():
	if is_multiplayer_authority():
		$CameraBase/Camera3D.current = true
	Input.mouse_mode = 2

func _input(event):
	if is_multiplayer_authority():
		if event.is_action_pressed("exit"):
			get_tree().quit()
		if event is InputEventMouseMotion:
			camerabase.rotation.x -= deg_to_rad(event.relative.y * 0.2)
			camerabase.rotation.x = clamp(camerabase.rotation.x, deg_to_rad(-75), deg_to_rad(80))
			rotation.y -= deg_to_rad(event.relative.x * 0.2)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()

func push_back():
	velocity.x += 25
	
	move_and_slide()
