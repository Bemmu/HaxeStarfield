import flash.display.*;
import flash.filters.*;
import flash.events.*;
import flash.geom.*;
import flash.utils.*;
import flash.ui.*;
import flash.media.*;
import Star;

class Game {
	var buffer:BitmapData = null;
	var stars:Array<Star> = null;

	function refresh(e:flash.events.Event) {
		buffer.fillRect(new Rectangle(0, 0, 960, 600), 0xff000000);
		for (star in stars) {
			var brightness = Std.int(Math.max(Math.min(1.0 - star.z*0.1, 1.0), 0.0) * 255);
			buffer.setPixel(
				Std.int((star.x - buffer.width/2)/star.z + buffer.width/2), 
				Std.int((star.y - buffer.height/2)/star.z + buffer.height/2), 
				0xff000000 + brightness + (brightness << 8) + (brightness << 16)
			);
			star.z -= 0.05;
			if (star.z < 0) {
				star.z = 10.0;
			}
		}
	}

	public function new() {
		buffer = new BitmapData(960, 600);
		flash.Lib.current.addChild(new Bitmap(buffer));
		flash.Lib.current.stage.addEventListener(Event.ENTER_FRAME, refresh);

		stars = new Array();
		var i = 10000;
		while (i > 0) {
			stars.push(new Star());
			i--;
		}
	}

	static function main() {
		var what = new Game();
	}
}