extends Control

const FINAL_Y = -10
const Y_STEP = 100
var after_seconds = 1;
var time_passed = 0;
var step = 0;
var start_animation = false
@onready var image_1: NinePatchRect = $Image1
@onready var image_2: NinePatchRect = $Image2
@onready var image_3: NinePatchRect = $Image3
@onready var image_4: NinePatchRect = $Image4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if start_animation == true and time_passed < after_seconds:
		time_passed += delta
	if time_passed > after_seconds:
		if step == 0:
			move_window(image_1)
		elif step == 1:
			move_window(image_2)
		elif step == 2:
			move_window(image_3)
		elif step == 3:
			move_window(image_4)


func move_window(node):
	print(node.position.y, FINAL_Y)
	if node.position.y > FINAL_Y:
		node.position = node.position - Vector2(0, min(Y_STEP, node.position.y - FINAL_Y))
	else:
		step += 1
		time_passed = 0


func _on_texture_button_button_up() -> void:
	start_animation = true
	after_seconds = 0.5
