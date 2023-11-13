extends Control

const MAX_CELLS = 16
const WIN_NUMBER = 2048
var cells
var rows
var cols
var is_move = false
var opened_numbers = 0
var number_cell_preload
var rng = RandomNumberGenerator.new()

func _ready():
	number_cell_preload = preload("res://game_objects/NumberCell.tscn")
	cells = get_tree().get_nodes_in_group('cells')
	rows = [get_tree().get_nodes_in_group('row1'),
			get_tree().get_nodes_in_group('row2'),
			get_tree().get_nodes_in_group('row3'),
			get_tree().get_nodes_in_group('row4')					
]
	cols = [get_tree().get_nodes_in_group('column1'),
			get_tree().get_nodes_in_group('column2'),
			get_tree().get_nodes_in_group('column3'),
			get_tree().get_nodes_in_group('column4')					
]
	generate_number_cell()
	

func generate_number_cell():
	if opened_numbers == 16:
		return
	var number_cell = number_cell_preload.instance()
	var color = number_cell.get_child(0).color
	
	rng.randomize()
	var i = rng.randi_range(0,cells.size() - 1)
	while cells[i].get_child_count() > 0:
		 i = rng.randi_range(0,cells.size() - 1)
	cells[i].add_child(number_cell)
	number_cell.get_child(0).color = Color.red
	yield(get_tree().create_timer(0.5),"timeout")
	number_cell.get_child(0).color = color
	opened_numbers +=1
	print(opened_numbers)
	
func move_numbers():
	if Input.is_action_just_pressed("ui_left"):
		for row in rows:
			for i in range(row.size()):
				if i == 0:
					continue
				var count = 0
				while count < i:
					if row[i - count].get_child_count() > 0 and row[i - count - 1].get_child_count() < 1:
						var child = row[i-count].get_child(0)
						row[i-count].remove_child(child)
						row[i-1 - count].add_child(child)
						is_move = true
					elif row[i - count].get_child_count() > 0 and row[i - count - 1].get_child_count() > 0:
						var labelOne = row[i - count].get_child(0).get_child(0).get_child(0)
						var labelTwo = row[i - count - 1].get_child(0).get_child(0).get_child(0)
						if (labelOne.text == labelTwo.text):
							var number = int(labelOne.text) * 2
							labelOne.text = str(number)
							var child = row[i-count].get_child(0)
							Events.emit_signal("change_color",child.get_child(0))
							var child2 = row[i-count - 1].get_child(0)
							row[i-count].remove_child(child)
							row[i-1 - count].remove_child(child2)
							row[i-1 - count].add_child(child)
							opened_numbers -=1
							is_move = true
					count +=1
		if is_move:
			generate_number_cell()
			is_move = false		
	elif Input.is_action_just_pressed("ui_right"):
		for row in rows:
			var temp_row = []
			for i in range(row.size() - 1,-1,-1):
				temp_row.append(row[i])
			for i in range(temp_row.size()):
				if i == 0:
					continue
				var count = 0
				while count < i:
					if temp_row[i - count].get_child_count() > 0 and temp_row[i - count - 1].get_child_count() < 1:
						var child = temp_row[i-count].get_child(0)
						temp_row[i-count].remove_child(child)
						temp_row[i-1 - count].add_child(child)
						is_move = true
					elif temp_row[i - count].get_child_count() > 0 and temp_row[i - count - 1].get_child_count() > 0:
						var labelOne = temp_row[i - count].get_child(0).get_child(0).get_child(0)
						var labelTwo = temp_row[i - count - 1].get_child(0).get_child(0).get_child(0)
						if (labelOne.text == labelTwo.text):
							var number = int(labelOne.text) * 2
							labelOne.text = str(number)
							var child = temp_row[i-count].get_child(0)
							Events.emit_signal("change_color",child.get_child(0))
							var child2 = temp_row[i-count - 1].get_child(0)
							temp_row[i-count].remove_child(child)
							temp_row[i-1 - count].remove_child(child2)
							temp_row[i-1 - count].add_child(child)
							opened_numbers -=1
							is_move = true
					count +=1
		if is_move:
			generate_number_cell()
			is_move = false	
	elif Input.is_action_just_pressed("ui_up"):
		for col in cols:
			for i in range(col.size()):
				if i == 0:
					continue
				var count = 0
				while count < i:
					if col[i - count].get_child_count() > 0 and col[i - count - 1].get_child_count() < 1:
						var child = col[i-count].get_child(0)
						col[i-count].remove_child(child)
						col[i-1 - count].add_child(child)
						is_move = true
					elif col[i - count].get_child_count() > 0 and col[i - count - 1].get_child_count() > 0:
						var labelOne = col[i - count].get_child(0).get_child(0).get_child(0)
						var labelTwo = col[i - count - 1].get_child(0).get_child(0).get_child(0)
						if (labelOne.text == labelTwo.text):
							var number = int(labelOne.text) * 2
							labelOne.text = str(number)
							var child = col[i-count].get_child(0)
							Events.emit_signal("change_color",child.get_child(0))
							var child2 = col[i-count - 1].get_child(0)
							col[i-count].remove_child(child)
							col[i-1 - count].remove_child(child2)
							col[i-1 - count].add_child(child)
							opened_numbers -=1
							is_move = true
					count +=1						
		if is_move:
			generate_number_cell()
			is_move = false					
	elif Input.is_action_just_pressed("ui_down"):
		for col in cols:
			var temp_col = []
			for i in range(col.size() - 1,-1,-1):
				temp_col.append(col[i])
			for i in range(temp_col.size()):
				if i == 0:
					continue
				var count = 0
				while count < i:
					if temp_col[i - count].get_child_count() > 0 and temp_col[i - count - 1].get_child_count() < 1:
						var child = temp_col[i-count].get_child(0)
						temp_col[i-count].remove_child(child)
						temp_col[i-1 - count].add_child(child)
						is_move = true
					elif temp_col[i - count].get_child_count() > 0 and temp_col[i - count - 1].get_child_count() > 0:
						var labelOne = temp_col[i - count].get_child(0).get_child(0).get_child(0)
						var labelTwo = temp_col[i - count - 1].get_child(0).get_child(0).get_child(0)
						if (labelOne.text == labelTwo.text):
							var number = int(labelOne.text) * 2
							labelOne.text = str(number)
							var child = temp_col[i-count].get_child(0)
							Events.emit_signal("change_color",child.get_child(0))
							var child2 = temp_col[i-count - 1].get_child(0)
							temp_col[i-count].remove_child(child)
							temp_col[i-1 - count].remove_child(child2)
							temp_col[i-1 - count].add_child(child)
							opened_numbers -=1
							is_move = true
					count +=1				
		if is_move:
			generate_number_cell()
			is_move = false	
func _process(delta):
		if Input.is_action_just_pressed("ui_accept"):
			generate_number_cell()
		move_numbers()
	
	



func _on_Button_pressed():
	get_tree().reload_current_scene() # Replace with function body.
