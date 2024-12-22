package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var _background:FlxSprite;

	override public function create()
	{
		super.create();
		// Load bg with center tile in view.
		_background = new FlxSprite();
		_background.loadGraphic("assets/images/level_debug.png");
		_background.x = -640;
		add(_background);

		// Track bg in debugger.
		FlxG.watch.add(_background, "x", "bg.x");
		FlxG.watch.add(_background, "y", "bg.y");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		handleCameraPan();
	}

	private function clampCameraBounds()
	{
		// Left bound.
		if (_background.x > 0)
			_background.x = 0;

		// Right bound.
		if (_background.x < -_background.width + FlxG.width)
			_background.x = -_background.width + FlxG.width;
	}

	private function handleCameraPan()
	{
		var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		if (left && right)
			left = right = false;

		var movement:Float = 0.0;
		var panSpeed:Float = 640 * 0.01;
		if (left)
			movement = 1 * panSpeed;
		if (right)
			movement = -1 * panSpeed;

		_background.x += movement;
		clampCameraBounds();
	}
}
