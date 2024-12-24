extends XRToolsSceneBase

@export var player_scene : PackedScene


func _enter_tree():
	#set_multiplayer_authority(int(str(name)))
	$MultiplayerSpawner.spawn_function = spawn_player
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.player_loaded.rpc_id(1) # Tell the server that this peer has loaded.
	#$MultiplayerSpawner.spawned.connect(_on_player_added)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_game():
	# When loading the scene we add proxies for all existing players
	print("start_game + from " + str(multiplayer.get_unique_id()))
	print("start_game + nb players : " + str(Lobby.players.size()))
	for id in Lobby.players:
		print("start_game " + str(id))
		#instantiate_player(id)
		#init_proxy_local_proxy.rpc_id(id)
		$MultiplayerSpawner.spawn(id)
		
		
	#init_proxy_local_proxy.rpc()
	#var player: Node3D = $MultiplayerSpawner/Players.find_child(str(multiplayer.get_unique_id()))
	#player.xr_origin_node = get_tree().root.find_child("XROrigin3D")

func spawn_player(id):
	print("spawning " + str(id)  + " from " + str(multiplayer.get_unique_id()))
	var player = player_scene.instantiate()
	player.name = str(id)
	var offset = $MarkerPlayer1.transform if id == 1 else $MarkerPlayer2.transform
	player.offset = offset
	
	if id == multiplayer.get_unique_id():
		print("setting xr_origin_node")
		var xr_origin_node = get_node("XROrigin3D")
		player.xr_origin_node = xr_origin_node
		
	return player

#func instantiate_player(id):
	#var player = player_scene.instantiate()
	#player.name = str(id)
	#$MultiplayerSpawner/Players.add_child(player)
	#player.position = $MarkerPlayer1.position if id == 1 else $MarkerPlayer2.position
	
#func _on_player_added(node):
	#print("_on_player_added from " + str(multiplayer.get_unique_id()))
	#print(node.name)
	###init_proxy_local_proxy.rpc_id(multiplayer.get_unique_id())
	##init_proxy_local_proxy()
	#pass
	
#@rpc("call_local")
#func init_proxy_local_proxy():
	#var id = multiplayer.get_unique_id()
	#print("init_proxy_local_proxy from " + str(id))
		#
	#var player: Node3D = $MultiplayerSpawner/Players.find_child(str(id))
	#if player:
		## we only do this if the proxy related to our local instance is spawned
		#player.xr_origin_node = get_tree().root.find_child("XROrigin3D")
