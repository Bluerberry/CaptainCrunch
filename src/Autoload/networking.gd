extends Node

# -------------------> Variables

signal player_update
const PORT = 1234
var peer = NetworkedMultiplayerENet.new()

# -------------------> Functions

# Sets the networking node up
func _ready() -> void:
	# Connect signals
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")


# Starts the game as server
func create_server(username) -> void:
	tools.info("Creating server at port " + str(PORT))

	# Create server
	peer.create_server(PORT, 8)
	get_tree().network_peer = peer

	# Update server in globals
	globals.player.username = username

	# Add player to globals
	globals.players[1] = globals.player
	globals.spectators[1] = globals.player


# Starts the game as client
func create_client(username, target_ip) -> void:
	tools.info("Creating client connected to " + target_ip)

	# Create client
	peer.create_client(target_ip, PORT)
	get_tree().network_peer = peer

	# Update client in globals
	globals.player.id = get_tree().get_network_unique_id()
	globals.player.username = username

	# Add player to globals
	globals.players[globals.player.id] = globals.player
	globals.spectators[globals.player.id] = globals.player


# Sends info to newly connected player
func _player_connected(id) -> void:
	tools.info("Player " + str(id) + " has connected")
	
	# Add self to newly connected player's globals
	rpc_id(id, "add_player", globals.player.id, globals.player.username, globals.player.team, globals.player.roles)


# Destroys disconnected player
func _player_disconnected(id) -> void:
	tools.info("Player " + str(id) + " has disconnected")

	# Remove player from all globals
	globals.players.erase(id)
	globals.team_red.erase(id)
	globals.team_blue.erase(id)
	globals.spectators.erase(id)

	# Update all player reliant scenes
	emit_signal("player_update")

# -------------------> Remote functions

# Adds newly connected player
remote func add_player(id, username, team, roles) -> void:
	tools.info("Adding new player " + username + " (" + str(id) + ")")

	# Creates a new player
	var player = globals.Player.new()
	player.id = id
	player.username = username
	player.team = team
	player.roles = roles

	# Add player to globals
	globals.players[id] = player
	if team == "red":
		globals.team_red[id] = player
	elif team == "blue":
		globals.team_blue[id] = player
	else:
		globals.spectators[id] = player

	# Update all player reliant scenes
	emit_signal("player_update")


# Sets team of target player
remotesync func set_player_team(id, team) -> void:
	tools.info("Setting player " + globals.players[id].username + " (" + str(id) + ") team to " + team)

	# Remove player from all teams
	globals.team_red.erase(id)
	globals.team_blue.erase(id)
	globals.spectators.erase(id)

	# Set players team
	globals.players[id].team = team

	# Add player to correct team
	if team == "red":
		globals.team_red[id] = globals.players[id]
	elif team == "blue":
		globals.team_blue[id] = globals.players[id]
	else:
		globals.spectators[id] = globals.players[id]

	# Update all player reliant scenes
	emit_signal("player_update")


# Sets player roles
remotesync func set_player_roles(id, roles) -> void:
	tools.info("Setting player " + globals.players[id].username + " (" + str(id) + ") roles to " + str(roles))
	
	# Set new roles
	globals.players[id].roles = roles
	
	# Update all player reliant scenes
	emit_signal("player_update")
