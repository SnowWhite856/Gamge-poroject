extends Node3D

func _on_game_mode_selector_area_body_entered(body):
	if body is player and body.name == "1":
		body.set_process_input(false)
		Input.mouse_mode = 0
		get_node("GameModeSelction").visible = true


func _on_game_mode_selector_area_body_exited(body):
	if body is player and body.name == "1":
		body.set_process_input(true)
		Input.mouse_mode = 2
		get_node("GameModeSelction").visible = false
