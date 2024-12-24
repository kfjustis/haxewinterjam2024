package;

import CatBoss;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	var _debugHud:FlxCamera;
	var _debugLine:FlxSprite;

	var _background:FlxSprite;
	var _charCam:FlxCamera;

	override public function create()
	{
		super.create();

		setLevelCameraBounds();

		// Load bg with center tile in view.
		_background = new FlxSprite();
		_background.loadGraphic("assets/images/level_debug.png");
		_background.x = -640;
		add(_background);

		// Test adding an object to the group relative to the background.
		var sprite:FlxSprite = new FlxSprite();
		sprite.makeGraphic(64, 64, FlxColor.BLUE);
		sprite.x = (640 / 2) - 32;
		sprite.y = 480 / 2 - 32;
		add(sprite);

		// Track bg in debugger.
		FlxG.watch.add(_background, "x", "bg.x");
		FlxG.watch.add(_background, "y", "bg.y");

		// Add character cam.
		_charCam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		FlxG.cameras.add(_charCam, false);
		_charCam.bgColor = 0x0;

		// Add cat.
		var catBoss = new CatBoss();
		add(catBoss);
		catBoss.camera = _charCam;

		// Add debug center lines on a separate cam.
		#if debug
		_debugHud = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		FlxG.cameras.add(_debugHud, false);
		_debugHud.bgColor = 0x0;

		_debugLine = new FlxSprite();
		_debugLine.makeGraphic(FlxG.width, FlxG.height);
		add(_debugLine);
		_debugLine.camera = _debugHud;
		#end
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		scrollCamera();

		#if debug
		renderDebugLines();
		#end
	}

	private function scrollCamera()
	{
		var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		if (left && right)
			left = right = false;

		var movement:Float = 0.0;
		var panSpeed:Float = 640 * 0.01;
		if (left)
			movement = -1 * panSpeed;
		if (right)
			movement = 1 * panSpeed;

		FlxG.camera.scroll.x += movement;
	}

	private function setLevelCameraBounds()
	{
		final LEVEL_MIN_X:Float = -640;
		final LEVEL_MAX_X:Float = 1280;

		FlxG.camera.minScrollX = LEVEL_MIN_X;
		FlxG.camera.maxScrollX = LEVEL_MAX_X;
	}

	private function renderDebugLines()
	{
		final LINE_COLOR:FlxColor = FlxColor.LIME;

		// Vertical line.
		FlxSpriteUtil.fill(_debugLine, 0);
		FlxSpriteUtil.drawLine(_debugLine, 640 / 2.0, 0, 640 / 2.0, 480, {
			thickness: 1.0,
			color: LINE_COLOR
		});

		// Horizontal line.
		FlxSpriteUtil.drawLine(_debugLine, 0, 480 / 2.0, 640, 480 / 2.0, {
			thickness: 1.0,
			color: LINE_COLOR
		});
	}
}
