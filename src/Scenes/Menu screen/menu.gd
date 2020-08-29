#----------------------------> Dependencies

extends Node2D

#----------------------------> Variables

const PORT = 1234

onready var HostGame = get_node("HostGame")
onready var JoinGame = get_node("JoinGame")
onready var InputIP = get_node("InputIP")

#----------------------------> Radio functions

func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "_peer_connected") # Connect network_peer_connected signal


func _on_HostGame_pressed() -> void:
	print("Creating server...")
	
	var server = NetworkedMultiplayerENet.new() # Create ENet instance
	if server.create_server(PORT, 8) != OK: # Create server instance and handle resonse
		print('An error occured while creating server')
		return
	else:
		print('Ready')
	
	JoinGame.hide() # Hide join game button to prevent confusion
	InputIP.hide()
	HostGame.disabled = true # Disable host game button to prevent multiple ENet instances
	
	get_tree().set_network_peer(server) # Set self to network peer


func _on_JoinGame_pressed() -> void:
	print("Connecting to server...")
	
	var client = NetworkedMultiplayerENet.new() # Create ENet instance
	if client.create_client(InputIP.text, PORT) != OK: # Create client instance and handle response
		print("An error occured while connecting to server")
		return

	JoinGame.disabled = true # Disable join game button to prevent confusion
	InputIP.disabled = true
	HostGame.hide() # Hide host game button to prevent multiple ENet instances
	
	get_tree().set_network_peer(client) # Set self to network peer

func _peer_connected(id) -> void:
	print("Player connected to server")
