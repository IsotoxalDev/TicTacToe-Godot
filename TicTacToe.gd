extends Node2D
var t = {}
var b ="X"
const s = 3
onready var z = get_viewport_rect().size
func _draw():
	for l in range(1, s):
		var p = (z.x/s)*l;var c = Color.gainsboro
		draw_line(Vector2(p, 0), Vector2(p, z.y), c);draw_line(Vector2(0, p), Vector2(z.x, p),c)
	if t:
		for i in t.keys():
			var e = z.x/s;var center = i*e + Vector2(e/2, e/2)
			if t[i]=="O":draw_arc(center, 50, 0, 360, 1000, Color.aquamarine, 2, true)
			if t[i]=="X":
				var a = {"tl":center+Vector2(-50,-50),"tr":center+Vector2(50,-50),"bl":center+Vector2(50,50),"br":center+Vector2(-50,50)}
				var c = Color.lightpink
				draw_line(a.tl, a.bl, c, 2);draw_line(a.tr, a.br, c, 2)
func g(p: Vector2) -> Vector2:return Vector2(floor(p.x/(z.x/s)), floor(p.y/(z.y/s)))
func P(a: String, i: Vector2) -> bool:
	if !t.has(i):t[i] = a;update();b = "O" if b=="X" else "X";return false
	return true
func _input(e):
	if e is InputEventMouseButton:if e.button_index == BUTTON_LEFT and e.pressed:P(b, g(get_global_mouse_position()))
