extends Node

signal line_edit_focus_entered
signal line_edit_focused_exit

@export var address = "127.0.0.1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.player_connected.connect(player_connected)
	Lobby.player_disconnected.connect(player_disconnected)
	Lobby.server_disconnected.connect(server_disconnected)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$NbPlayers.text = "NB players: " + str(Lobby.players.size())
	if len($LineEdit.text) > 0:
		$Host.disabled = false
	else:
		$Host.disabled = true
		
	if Lobby.players.size() > 1 and multiplayer.is_server() :
		$StartGame.disabled = false
	else:
		$StartGame.disabled = true
	pass

func player_connected(peer_id, player_info):
	print("player_connected " + str(peer_id) + " " + str(player_info))
	
func player_disconnected(peer_id):
	print("player_disconnected " + str(peer_id))
	
func server_disconnected():
	print("server_disconnected")


func _on_host_pressed() -> void:	
	$ServerBrowser.setup_broadcaster($LineEdit.text)
	Lobby.create_game()
	
	
func _on_line_edit_focus_entered() -> void:
	line_edit_focus_entered.emit()


func _on_line_edit_focus_exited() -> void:
	line_edit_focused_exit.emit()


func _on_line_edit_text_submitted(new_text: String) -> void:
	$LineEdit.release_focus()


func _on_server_browser_join_game(ip: Variant) -> void:
	Lobby.join_game(ip)


func _on_start_game_pressed() -> void:
	Lobby.load_game.rpc("res://level1.tscn")
