extends GameExperiment

@export var layout_texture: Texture2D

enum types {
	none,
	tree,
	rock,
	player,
}

enum flip_axis {
	none,
	x,
	y,
}

const type_colors := {
	types.tree: "22b14c",
	types.rock: "7f7f7f",
	types.player: "ff7f27",
}


func _ready() -> void:
	var layout = get_layout()
	var flipped_layout = flip_layout(layout, flip_axis.y)

	## to draw this:
	#for row in layout:
		#for cell in row:
			#if tiles.has(cell):
				#_tiles.set_cell(
					#0, Vector2i(x, y), 0, tiles[cell]
				#)
			#if nodes.has(cell):
				#var new_node = nodes[cell].instantiate()
				#_nodes.add_child(new_node)
				#new_node.position = Vector2(x * 64, y * 64)

func get_layout() -> Array[Array]:
	var layout_image := layout_texture.get_image()
	var rows := []

	for y in layout_texture.get_height():
		var row := []

		for x in layout_texture.get_width():
			var type := types.none
			var color := layout_image.get_pixel(x, y).to_html(false)

			for t in types.values():
				if not type_colors.has(t):
					continue
				if color == type_colors[t]:
					type = t

			row.append(type)
		rows.append(row)
	return rows


func flip_layout(layout: Array[Array], flip := flip_axis.none) -> Array[Array]:
	var new_rows := []

	for row in layout:
		var new_row := []

		for cell in row:
			if flip == flip_axis.x:
				new_row.push_front(cell)
			else:
				new_row.push_back(cell)

		if flip == flip_axis.y:
			new_rows.push_front(new_row)
		else:
			new_rows.push_back(new_row)

	return new_rows
