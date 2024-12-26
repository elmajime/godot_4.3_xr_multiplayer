extends XRToolsSceneBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lobby_scene = get_node("Lobby_UI_2d_to_3d/Viewport/LobbyUI")
	lobby_scene.line_edit_focus_entered.connect(_on_line_edit_focus_entered)
	lobby_scene.line_edit_focused_exit.connect(_on_line_edit_focused_exit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lobby_ui_create_game() -> void:
	Lobby.create_game()


func _on_lobby_ui_join_game() -> void:
	Lobby.join_game() # arg is empty -> default hardcoded adress is used
	
func _on_line_edit_focus_entered():
	$Keyboard.visible = true
	
func _on_line_edit_focused_exit():
	$Keyboard.visible = false
	
