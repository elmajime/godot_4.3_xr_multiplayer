extends Node3D

@export var xr_origin_node: Node3D
var xr_head : Node3D
var xr_left_hand : Node3D
var xr_right_hand : Node3D

func _enter_tree():
	set_multiplayer_authority(int(str(name)))
	
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_multiplayer_authority() and xr_origin_node:
		xr_head = xr_origin_node.find_child("XRCamera3D")
		xr_left_hand = xr_origin_node.find_child("LeftHand")
		xr_right_hand = xr_origin_node.find_child("RightHand")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_multiplayer_authority() and xr_origin_node:
		$Head.transform = xr_head.transform
		$Head/LeftHand.transform = xr_left_hand.transform
		$Head/RightHand.transform = xr_right_hand.transform
