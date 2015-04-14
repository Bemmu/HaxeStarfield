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

	var frames = 0;
	var fpsCountStart = 0.0;

	function increaseStrain() {
		var i = stars.length == 0 ? 1000 : stars.length * 0.5;
		while (i > 0) {
			stars.push(new Star());
			i--;
		}
	}

	function refresh(e:flash.events.Event) {
		frames++;
		if (Date.now().getTime() - fpsCountStart > 1000) {
			if (fpsCountStart > 0) {
				trace(stars.length + " stars at " + frames + " fps");
			}

			if (frames >= Std.int(flash.Lib.current.stage.frameRate)) {				
				increaseStrain();
			}

			frames = 0;
			fpsCountStart = Date.now().getTime();
		}

		buffer.fillRect(new Rectangle(0, 0, 960, 600), 0xff000000);
		var t = Date.now().getTime();
		for (star in stars) {
			star.draw(buffer, t);
			star.z -= 0.05;
			if (star.z < 0) {
				star.z = 10.0;
			}
		}
	}

	var channel:SoundChannel;

	public function new() {
		// lame -b 320 -h engine.wav engine.mp3
		haxe.Timer.delay(function () {
			var data = haxe.Resource.getBytes("engine-sound");
			var snd = new Sound();
			snd.loadCompressedDataFromByteArray(data.getData(), data.length);
//			channel = snd.play(0, 9999);
		}, 250);

		trace("Space, the final frontier.");

		buffer = new BitmapData(960, 600);
		flash.Lib.current.addChild(new Bitmap(buffer));
		flash.Lib.current.stage.addEventListener(Event.ENTER_FRAME, refresh);

		stars = new Array();
		increaseStrain();
	}

	static function main() {
		var what = new Game();
	}
}