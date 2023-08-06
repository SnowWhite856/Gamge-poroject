extends Control


func _on_button_pressed():
	self.visible = false
	Networking.start_server()

func _on_button_2_pressed():
	self.visible = false
	Networking.join_server()
