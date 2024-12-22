package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		applyWindowSettings();
		addChild(new FlxGame(0, 0, SetupState));
	}

	private function applyWindowSettings()
	{
		// Position window for debugging.
		var window = FlxG.stage.window;
		if (window != null)
		{
			window.x = 0;
			window.y = 0;
		}
	}
}
