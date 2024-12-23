extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.player_connected.connect(player_connected)
	Lobby.player_disconnected.connect(player_disconnected)
	Lobby.server_disconnected.connect(server_disconnected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func player_connected(peer_id, player_info):
	print("player_connected " + str(peer_id) + " " + str(player_info))
	
func player_disconnected(peer_id):
	print("player_disconnected " + str(peer_id))
	
func server_disconnected():
	print("server_disconnected")


func _on_create_game_pressed() -> void:
	Lobby.create_game()


func _on_join_game_pressed() -> void:
	Lobby.join_game()
