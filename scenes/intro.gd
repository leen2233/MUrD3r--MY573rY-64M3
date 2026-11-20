extends Control

const SUBTITLES := {
	"Image1": [
		"ZZZ..."
	],
	"Image2": [
		"Ah"
	]
}

const FINAL_Y = -10
var current_window_index = -1;
var current_subtitle_index = -1;

var current_action := "window";

@onready var container: Control = $WindowsContainer


func move_window_to_screen(index):
	if container.get_child_count() <= index:
		return
	var window = container.get_child(index)
	
	current_action = ""
	var tween = create_tween()
	tween.tween_property(window, "position:y", FINAL_Y, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await tween.finished
	
	if window.name in SUBTITLES:
		current_action = "subtitle"
		current_subtitle_index = -1
		await get_tree().create_timer(0.3).timeout
		show_next_subtitle()
	else:
		current_action = "window"
	

func move_next_window():
	current_window_index += 1
	move_window_to_screen(current_window_index)

func show_next_subtitle():
	current_subtitle_index += 1
	var window = container.get_child(current_window_index)
	var container: Control = window.get_node("SubtitlesContainer") 
	container.visible = true
	
	var text_node: RichTextLabel = container.get_node("SubtitleText")
	
	if window.name in SUBTITLES:
		if len(SUBTITLES[window.name]) > current_subtitle_index:
			var text = SUBTITLES[window.name][current_subtitle_index]
			text_node.text = text
			if len(SUBTITLES[window.name]) <= current_subtitle_index + 1:
				current_action = "window"
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if current_action == "window":
			move_next_window()
		elif current_action == "subtitle":
			show_next_subtitle()

func _on_texture_button_button_up() -> void:
	move_next_window()
