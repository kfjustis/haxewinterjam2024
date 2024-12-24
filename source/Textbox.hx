import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxColor;

class Textbox extends FlxSprite
{
	var _typeText:FlxTypeText;
	var _terminator:FlxSprite;
	var _terminatorOriginY:Float;
	var _typing:Bool;

	var _character:FlxSprite;

	override public function new()
	{
		super();

		loadGraphic("assets/images/textbox.png");
		FlxG.watch.add(this, "x", "tbox.x");
		FlxG.watch.add(this, "y", "tbox.y");
		x = 80;
		y = 15;

		_terminator = new FlxSprite();
		_terminator.loadGraphic("assets/images/terminator.png");
		_terminator.x = x + width - 25;
		_terminatorOriginY = y + height - 25;
		_terminator.y = _terminatorOriginY;
		_terminator.visible = false;

		_typeText = new FlxTypeText(50, 10, cast(width, Int) - 20, "", 20);
		_typeText.color = FlxColor.WHITE;
		FlxG.watch.add(_typeText, "x", "text.x");
		FlxG.watch.add(_typeText, "y", "text.y");
		_typeText.camera = camera;
		_typeText.useDefaultSound = true;
		_typeText.x = x + 10;
		_typeText.y = y + 10;

		_typing = false;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Pulse the terminator.
		static var offset:Float = 0.0;
		offset += 1 / 5 * elapsed;
		if (_terminator.y - _terminatorOriginY > 4.0)
		{
			offset = 0;
			_terminator.y = _terminatorOriginY;
		}
		_terminator.y += offset;
	}

	public function addElements(owningState:FlxState)
	{
		owningState.add(_typeText);
		owningState.add(_terminator);
	}

	public function setCamera(owningCamera:FlxCamera)
	{
		_typeText.camera = owningCamera;
		_terminator.camera = owningCamera;
	}

	public function playText(text:String)
	{
		if (_typing)
		{
			return;
		}

		_typing = true;
		if (_character != null)
		{
			_character.animation.play("talk");
		}

		_typeText.resetText(text);
		_typeText.start(0.05, false, false, [S], onComplete);
	}

	public function attachCharacter(character:FlxSprite)
	{
		_character = character;
	}

	private function onComplete()
	{
		_terminator.visible = true;
		_typing = false;
		if (_character != null)
		{
			_character.animation.play("idle");
		}
	}
}
