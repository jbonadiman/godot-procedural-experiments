extends GameExperiment

@onready var _tile_map := $TileMap as TileMap

func _ready() -> void:
	_tile_map.clear()

	var cells: Array[Vector2i] = [
		Vector2i(-1, 0),
		Vector2i(0, 0),
		Vector2i(-1, 1),
		Vector2i(0, 1),
	]

	_tile_map.set_cells_terrain_connect(
		0,
		cells,
		0,
		0,
		false
	)
