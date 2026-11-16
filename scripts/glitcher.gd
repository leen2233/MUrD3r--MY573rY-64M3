extends RichTextLabel

var passed_time = 0
var progress = 0
var changed_chars = {}

const ORIGINAL_TEXT = '[color=#00Bfff]THIS[/color]
LEADS       
TO [color="#ff007a"]YOU[/color]'
const LEET_CHARS_DICT = {"T": "7", "I": "1", "S": "5", "E": "3", "A": "V", "O":"0"}
const LEET_CHARs = "TISEAO"


func _ready() -> void:
	pass

var counter=0
func _process(delta: float) -> void:
	passed_time += delta
	
	if passed_time > 0.3 and progress < 6:
		var t = text
		var n = randi_range(0, 5)
		for i in range(n):
			var ch_to_change = LEET_CHARs[randi_range(0, 5 - progress)]
			if ch_to_change not in changed_chars or not changed_chars[ch_to_change]:
				t = t.replace(ch_to_change, LEET_CHARS_DICT[ch_to_change])
				changed_chars[ch_to_change] = true
			else:
				t = t.replace(LEET_CHARS_DICT[ch_to_change], ch_to_change)
				changed_chars[ch_to_change] = false
				
		counter += 1
		if counter == 5:
			var ch_to_change = LEET_CHARs[5 - progress]
			if ch_to_change not in changed_chars or not changed_chars[ch_to_change]:
				t = t.replace(ch_to_change, LEET_CHARS_DICT[ch_to_change])
				
		text = t
		passed_time = 0
		
		if counter == 5:
			progress += 1
			counter = 0
