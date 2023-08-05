extends Node3D

var multiplayer_peer = ENetMultiplayerPeer.new()

const host = "localhost"
const PORT = 9999

var player_scene : PackedScene = preload("res://Scenes/player.tscn")

func start_server():
	multiplayer_peer.create_server(PORT)
	multiplayer.multiplayer_peer = multiplayer_peer
	multiplayer.peer_connected.connect(add_player)
	add_player()

func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	get_parent().get_node("/root/Map").add_child(player)

func join_server():
	multiplayer_peer.create_client(host, PORT)
	multiplayer.multiplayer_peer = multiplayer_peer
