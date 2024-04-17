extends Node2D

var nodes = [Vector2i(0, 0) + Vector2i(16, 16)]


func _ready():
	queue_redraw()


func _draw():
	for node in nodes:
		draw_circle(node, 5, Color.CHARTREUSE)
