extends Node3D

@export var xr_origin_node: Node3D
@export var offset: Transform3D

var xr_head : Node3D
var xr_left_hand : Node3D
var xr_right_hand : Node3D

func _enter_tree():
	set_multiplayer_authority(int(str(name)))

# Called when the node enters the scene tree for the first time.
func _ready():
	if xr_origin_node:
		xr_head = xr_origin_node.get_node("XRCamera3D")
		xr_left_hand = xr_origin_node.get_node("LeftHand")
		xr_right_hand = xr_origin_node.get_node("RightHand")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if xr_origin_node:			
		$Head.transform = offset * xr_head.transform
		$LeftHand.transform = offset * xr_left_hand.transform
		$RightHand.transform = offset * xr_right_hand.transform
