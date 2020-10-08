extends Node

# -------------------> Variables

var time

# -------------------> Functions

# Prints debug information with the INFO tag
func info(msg) -> void:
	time = OS.get_time()
	print("(" + str(time.hour).pad_zeros(2) + ":" + str(time.minute).pad_zeros(2) + ":" + str(time.second).pad_zeros(2) + ") [INFO] " + msg)


# Prints debug information with the WARN tag
func warn(msg) -> void:
	time = OS.get_time()
	print("(" + str(time.hour).pad_zeros(2) + ":" + str(time.minute).pad_zeros(2) + ":" + str(time.second).pad_zeros(2) + ") [WARN] " + msg)


# Prints debug information with the ERR tag
func err(msg) -> void:
	time = OS.get_time()
	print("(" + str(time.hour).pad_zeros(2) + ":" + str(time.minute).pad_zeros(2) + ":" + str(time.second).pad_zeros(2) + ") [ERR] " + msg)
