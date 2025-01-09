extends Control

signal found_server
signal server_removed

signal join_game(ip)

@onready var broadcast_timer :Timer = $BroadcastTimer

@export var listen_port = 7002
@export var broadcast_port = 7001
@export var broadcast_address = "192.168.0.255"
@export var server_info: PackedScene

var RoomInfo = {"name":"name", "player_count":0}
var broadcaster: PacketPeerUDP
var listener: PacketPeerUDP 

func _ready() -> void:
	setup_listener()

func setup_listener():
	listener = PacketPeerUDP.new()
	var ok = listener.bind(listen_port)
	if ok == OK:
		print("Listening " + str(listen_port))
		$Label2.text="Bound to listen port: true"
	else:
		print("Failed to listen to " + str(listen_port))
		$Label2.text="Bound to listen port: false"
	pass
	
func _process(delta: float) -> void:
	if listener.get_available_packet_count() > 0:
		var server_ip = listener.get_packet_ip()
		var server_port = listener.get_packet_port()
		
		var bytes = listener.get_packet()
		var data = bytes.get_string_from_ascii()
		if len(data) > 0:
			var room_info = JSON.parse_string(data)
			print(str(server_ip) + " " + str(server_port) + " room info: " + str(room_info))
			
			var child = $Panel/VBoxContainer.find_child(room_info.name, false, false)
			if child != null:
				child.get_node("IP").text = str(server_ip)
				child.get_node("PlayerCount").text = str(room_info.player_count)
			else:
				child = server_info.instantiate()
				child.name = room_info.name
				child.get_node("Name").text = room_info.name
				child.get_node("IP").text = str(server_ip)
				child.get_node("PlayerCount").text = str(room_info.player_count)
				child.join_game.connect(join_ip)
				$Panel/VBoxContainer.add_child(child)
	pass
	
func join_ip(ip):
	join_game.emit(ip)

func setup_broadcaster(room_name):
	RoomInfo.name = room_name
	
	broadcaster = PacketPeerUDP.new()
	broadcaster.set_broadcast_enabled(true)
	broadcaster.set_dest_address(broadcast_address, listen_port)
	var ok = broadcaster.bind(broadcast_port)
	if ok == OK:
		print("Bound to " + str(broadcast_port))
	else:
		print("Failed to bind to " + str(broadcast_port))
		
	broadcast_timer.start()

func _on_broadcast_timer_timeout() -> void:
	print("broadcast game")
	RoomInfo.player_count = Lobby.players.size()
	
	var data = JSON.stringify(RoomInfo)
	var packet = data.to_ascii_buffer()
	broadcaster.put_packet(packet)
	pass # Replace with function body.
	
func _exit_tree() -> void:
	clean_up()
	
func clean_up():
	listener.close()
	
	$BroadcastTimer.stop()
	if broadcaster != null:
		broadcaster.close()
