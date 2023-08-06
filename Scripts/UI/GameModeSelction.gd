extends Control

func list_files_in_directory(path):
	var files = []
	var dir = DirAccess.open(path)
	if dir.list_dir_begin() == OK:
		while true:
			var file = dir.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				files.append(file)
		
		dir.list_dir_end()
	
	return files

func _ready():
	populate_grid(list_files_in_directory("res://Scenes/GameModes"))

func populate_grid(files):
	var cell = preload("res://Scenes/UI/Cell.tscn").instantiate()
	for file in files:
		cell.gamemodename = file
		$GridContainer.add_child(cell)
