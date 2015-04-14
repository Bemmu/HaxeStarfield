import flash.display.*;
import flash.geom.*;

@:bitmap("star.png") class Shine extends flash.display.BitmapData {}

class Star {
	public var x:Float;
	public var y:Float;
	public var z:Float;
	static var shine = new Shine(0, 0);
	static var alphas:BitmapData = null;

	private function makeAlphas() {
		alphas = new BitmapData(32 * 256, 32, true, 0x00000000);
		for (i in 0...256) {
			var alphaBitmap:BitmapData = new BitmapData(32, 32, true, i << 24);
			alphas.copyPixels(shine, new Rectangle(0, 0, 32, 32), new Point(i * 32, 0), alphaBitmap, new Point(0,0), true);			
		}
	}

	public function new() {
		x = Std.random(6400) - 3200;
		y = Std.random(4000) - 2000;
		z = Std.random(1000) * 0.01;
		if (alphas == null) {
			makeAlphas();
		}
	}

	public function draw(buffer:BitmapData, t:Float) {
		var dist = Math.max(Math.min(1.0 - z*0.2, 1.0), 0.0);
		var px = Std.int((x - buffer.width/2)/z + buffer.width/2);
		var py = Std.int((y - buffer.height/2)/z + buffer.height/2) + Math.sin(Math.PI*2 + t * 0.0002) * 500;
		var vignetting = 1.0 - Math.sqrt(
			(py-buffer.height/2)*(py-buffer.height/2) + (px-buffer.width/2)*(px-buffer.width/2)
		)/Math.sqrt((buffer.width/2)*(buffer.width/2) + (buffer.height/2)*(buffer.height/2));

		var brightness = Std.int(Math.sin(vignetting*2.0) * dist * 255);

/*		buffer.setPixel(
			px, 
			py, 
			0xff000000 + brightness + (brightness << 8) + (brightness << 16)
		);*/

//		trace(@type Shine);
		buffer.copyPixels(alphas, new Rectangle(32 * brightness, 0, 32, 32), new Point(px - 16, py - 16), true);
	}
}