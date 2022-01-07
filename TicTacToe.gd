extends Control

var tiles_occupied = {}
var player = true
var player_alias = "X"

export var x_size = 50
export var split = 3

func _draw():
	var size = get_viewport_rect().size
	for line in range(1, split):
		var line_pos = (size.x/split)*line 
		draw_line(Vector2(line_pos, 0), Vector2(line_pos, size.y), Color.gainsboro)
		draw_line(Vector2(0, line_pos), Vector2(size.x, line_pos), Color.gainsboro)
	if tiles_occupied:
		for tile in tiles_occupied.keys():
			var tile_size = size.x/split
			var center = tile*tile_size + Vector2(tile_size/2, tile_size/2)
			if tiles_occupied[tile] == "O":
				draw_arc(center, 50, 0, 360, 1000, Color.aquamarine, 2, true)
			if tiles_occupied[tile] == "X":
				var start_1 = center + Vector2(-x_size, -x_size)
				var start_2 = center + Vector2(x_size, -x_size)
				var end_1 = center + Vector2(x_size, x_size)
				var end_2 = center + Vector2(-x_size, x_size)
				draw_line(start_1, end_1, Color.lightpink, 2)
				draw_line(start_2, end_2, Color.lightpink, 2)

func get_tile(tile_pos: Vector2) -> Vector2:
	var size = get_viewport_rect().size
	var tile = Vector2.ZERO
	tile.x = floor(tile_pos.x/(size.x/split))
	tile.y = floor(tile_pos.y/(size.y/split))
	return tile

func play(alias: String, tile: Vector2) -> bool:
	if !tiles_occupied.has(tile):
		tiles_occupied[tile] = alias
		update()
		player_alias = "O" if player_alias == "X" else "X"
		return false
	return true

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_mask == BUTTON_MASK_LEFT and event.pressed:
			if !player: return
			play(player_alias, get_tile(get_global_mouse_position()))
