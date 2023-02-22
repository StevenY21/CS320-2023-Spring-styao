use "./../../../mysmlib/mysmlib-cls.sml";


fun quiz02_01(word: string): char -> int = 
	fn(cs: char) => string_foreach(word, fn(cs2:char) => if cs = cs2 then 1 else 0)