extends Control

const MAX_CELLS = 16
var cells
var rows
var cols

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
	rng.randomize()
	var i = rng.randi_range(0,cells.size() - 1)
	while cells[i].get_child_count() > 0:
		 i = rng.randi_range(0,cells.size() - 1)
	cells[i].add_child(number_cell)
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
					count +=1
					
					
	
func _process(delta):
		if Input.is_action_just_pressed("ui_accept"):
			generate_number_cell()
		move_numbers()
	
	

