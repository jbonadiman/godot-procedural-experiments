extends GameExperiment

@onready var _line_edit := $VBoxContainer/HBoxContainer/LineEdit as LineEdit
@onready var _grid_container := $VBoxContainer/GridContainer as GridContainer

var generator: RandomNumberGenerator

func pick_random_number() -> void:
	_line_edit.text = str(randi() % 100)


func pick_random_words() -> void:
	_line_edit.text = "-".join(get_words(generator))


func update_random_sample() -> void:
	generator.seed = get_hash_from_words(_line_edit.text.split("-"))

	for child in _grid_container.get_children():
		child.text = str(generator.randi() % 100)


func _ready() -> void:
	generator = RandomNumberGenerator.new()
	refresh()


func refresh() -> void:
	pick_random_words()
	update_random_sample()


func get_hash_from_words(words: PackedStringArray) -> int:
	var complete = ""

	for word in words:
		complete += word \
			.trim_prefix(" ") \
			.trim_suffix(" ") \
			.to_lower()

	return complete.hash()

func get_words(generator: RandomNumberGenerator, number := 3) -> PackedStringArray:
	var words := get_all_words()
	var size := words.size()
	var chosen := []

	for i in range(3):
		chosen.append(words[generator.randi() % size])

	return PackedStringArray(chosen)


func get_all_words() -> PackedStringArray:
	if FileAccess.file_exists("res://resources/wordlist.txt"):
		return FileAccess \
			.open("res://resources/wordlist.txt", FileAccess.READ) \
			.get_as_text() \
			.split("\n", false)

	return PackedStringArray()


func _on_button_pressed() -> void:
	refresh()


func _on_line_edit_text_changed(_new_text: String) -> void:
	update_random_sample()
