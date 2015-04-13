class Star {
	public var x:Float;
	public var y:Float;
	public var z:Float;

	public function new() {
		x = Std.random(6400) - 3200;
		y = Std.random(4000) - 2000;
		z = Std.random(1000) * 0.01;
	}
}