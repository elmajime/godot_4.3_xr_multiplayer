extends XRToolsSceneBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lobby_ui_create_game() -> void:
	Lobby.create_game()


func _on_lobby_ui_join_game() -> void:
	Lobby.join_game() # arg is empty -> default hardcoded adress is used
