Showcode/Color
	var/definition
	var/name
	var/value

	New(var/name as text, var/value as text)
		src.name	= name
		src.value 	= value
		__definition()

	proc/__definition()
		src.definition = ".code_[name] { color: [value]; }"

	proc/wrap(var/text as text)
		return "<span class=\"code_[name]\">[text]</span>"

Showcode/ColorConfig
	var/list/color_map   = new()

	proc/add(var/Showcode/Color/C)
		color_map[C.name] = C

	proc/definition()
		var/definition = "<style type='text/css'>\n"
		for (var/name in color_map)
			var/Showcode/Color/C = color_map[name]
			definition += C.definition + "\n"
		definition += "</style>\n"
		return definition

	proc/wrap(var/text as text, var/name as text)
		var/Showcode/Color/C = color_map[name]
		return C.wrap(text)