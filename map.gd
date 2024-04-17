extends Node2D

const max_map_legth = 1024
const move_directions = [
	TileSet.CELL_NEIGHBOR_LEFT_SIDE,
	TileSet.CELL_NEIGHBOR_RIGHT_SIDE,
	TileSet.CELL_NEIGHBOR_TOP_SIDE,
	TileSet.CELL_NEIGHBOR_BOTTOM_SIDE
]

@onready var tilemap = $TileMap

var astar = AStar2D.new() 


func _ready():
	init_astar()

func init_astar():
	var used_cells = tilemap.get_used_cells(0)
	for cell in used_cells:
		var cell_id = get_cell_id(cell)
		if not astar.has_point(cell_id):
			astar.add_point(cell_id, cell)
		
		for direction in move_directions:
			var neighbour_cell = tilemap.get_neighbor_cell(cell, direction)
			if not neighbour_cell in used_cells:
				continue
		
			var neighbour_cell_id = get_cell_id(neighbour_cell)
			if not astar.has_point(neighbour_cell_id):
				astar.add_point(neighbour_cell_id, neighbour_cell)
			astar.connect_points(cell_id, neighbour_cell_id, false)

func get_cell_id(cell: Vector2i):
	return max_map_legth * cell.y + cell.x
