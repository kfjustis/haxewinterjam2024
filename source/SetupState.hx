package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.scaleModes.PixelPerfectScaleMode;

class SetupState extends FlxState
{
	override public function create()
	{
		super.create();

		applyGameSettings();

		FlxG.switchState(new PlayState());
	}

	private function applyGameSettings()
	{
		// Set scale mode.
		FlxG.scaleMode = new PixelPerfectScaleMode();
	}
}