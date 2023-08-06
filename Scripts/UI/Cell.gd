extends PanelContainer

var gamemodename : String

func _enter_tree():
	$MarginContainer/Label.text = gamemodename
