extends XRToolsSceneBase



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.player_loaded.rpc_id(1) # Tell the server that this peer has loaded.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_game():
	# When loading the scene we add proxies for all existing players
	print("from " + str(multiplayer.get_unique_id()))
	print("level 1 start_game")
	print("nb players : " + str(Lobby.players.size()))
	for player in Lobby.players:
		print(str(player))
