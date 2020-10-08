extends Node2D

# -------------------> Variables

onready var ButtonRed = get_node("ButtonRed")
onready var ButtonBlue = get_node("ButtonBlue")

# -------------------> Functions

# Sets the team select scene up
func _ready() -> void:
	# Connect signals
	networking.connect("player_update", self, "_update_level")


# Updates the team select scene
func _update_level() -> void:
	# Hide buttons acording to team size
	ButtonRed.disabled = true if globals.team_red.size() >= 4 else false
	ButtonBlue.disabled = true if globals.team_blue.size() >= 4 else false


# Adds player to team red
func _on_ButtonRed_pressed() -> void:
	networking.rpc("set_player_team", globals.player.id, "red")
	tools.info("Switching to role select")
	get_tree().change_scene("res://Scenes/RoleSelect/RoleSelect.tscn")


# Adds player to team blue
func _on_ButtonBlue_pressed() -> void:
	networking.rpc("set_player_team", globals.player.id, "blue")
	tools.info("Switching to role select")
	get_tree().change_scene("res://Scenes/RoleSelect/RoleSelect.tscn")
