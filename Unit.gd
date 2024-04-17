extends Node2D

@export var is_enemy = false
@export var ai_controlled = false

var courage = 0.2
var greed = 0.4
var obedience = 0.9

var chest_in_vision = null
var enemy_in_vision = null
var target = null

func _process(delta):
	if is_enemy:
		return
	
	if ai_controlled:
		if target == null:
			return
		global_position = global_position.move_toward(target.global_position, delta * 100)
	
	else:
		var y_pos = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		var x_pos = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		var input_vector = Vector2(x_pos, y_pos)
		global_position += input_vector * delta * 100

func _on_vision_range_area_entered(area):
	if area.owner.is_in_group("chest"):
		chest_in_vision = area.owner
	if area.owner.is_in_group("enemy"):
		enemy_in_vision = area.owner
	
	var max_action_value = -1
	
	var target_enemy_value = courage * float(enemy_in_vision != null)
	if target_enemy_value > max_action_value:
		max_action_value = target_enemy_value
		target = enemy_in_vision
	
	var target_chest_value = greed * float(chest_in_vision != null)
	if target_chest_value > max_action_value:
		max_action_value = chest_in_vision
		target = chest_in_vision
	
	print(name, " ", target)
