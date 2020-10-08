extends Control

# -------------------> Variables

onready var ChatHistory = get_node("VBoxContainer/ChatHistory")
onready var InputLabel = get_node("VBoxContainer/HBoxContainer/InputLabel")
onready var ChatInput = get_node("VBoxContainer/HBoxContainer/ChatInput")

var group_index = 0
var groups = [
	{"name":"Team", "color":"#25FADE"},
	{"name":"Match", "color":"#f44174"}
]

# -------------------> Functions

# React to user input
func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		
		# Move focus towards ChatInput on ENTER
		if event.scancode == KEY_ENTER:
			ChatInput.grab_focus()
			
		# Move focus away from ChatInput on ESCAPE
		elif event.scancode == KEY_ESCAPE:
			ChatInput.release_focus()
		
		# Cycle through groups on TAB
		elif event.scancode == KEY_TAB:
			group_index += 1
			if group_index >= 2:
				group_index = 0
			InputLabel.text = "[" + groups[group_index]["name"] + "]"
			InputLabel.set("custom_colors/font_color", Color(groups[group_index]["color"]))


# Add message when sent
func _on_ChatInput_text_entered(text: String) -> void:
	if ChatInput.text != "":
		for id in globals.players.keys() if group_index else (globals.team_red.keys() if globals.player.team == "red" else globals.team_blue.keys()):
			rpc_id(id, "add_message", globals.player.username, text, group_index)
		ChatInput.text = ""

# -------------------> Remote functions

# Add a message to ChatHistory
remotesync func add_message(username, text, group) -> void:
	tools.info("Recieved new message from " +  username)
	ChatHistory.bbcode_text += "\n"
	ChatHistory.bbcode_text += "[color=" + groups[group]["color"] + "]"
	ChatHistory.bbcode_text += "[" + username + "]: "
	ChatHistory.bbcode_text += text
	ChatHistory.bbcode_text += "[/color]"
