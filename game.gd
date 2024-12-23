extends Node # Or Node2D.


func _ready():
	# Preconfigure game.

	Lobby.player_loaded.rpc_id(1) # Tell the server that this peer has loaded.


# Called only on the server.
func start_game():
	# All peers are ready to receive RPCs in this scene.
	pass


func _on_lobby_ui_create_game() -> void:
	Lobby.create_game()


func _on_lobby_ui_join_game() -> void:
	Lobby.join_game() # arg is empty -> default hardcoded adress is used
