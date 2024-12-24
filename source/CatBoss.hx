import flixel.FlxG;
import flixel.FlxSprite;

class CatBoss extends FlxSprite
{
	final ORIGIN_X:Float = 10;
	final ORIGIN_Y:Float = 250;

	override public function new()
	{
		super();

		loadGraphic("assets/images/business_cat.png", true, 276, 336);
		scale.set(0.75, 0.75);
		updateHitbox();
		x = ORIGIN_X;
		y = ORIGIN_Y;

		configureAnimations();

		FlxG.watch.add(this, "x", "cat.x");
		FlxG.watch.add(this, "y", "cat.y");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([SPACE]))
		{
			// Toggle animations.
			if (animation.curAnim.name == "talk")
			{
				animation.stop();
				animation.play("idle");
			}
			else
			{
				animation.stop();
				animation.play("talk");
			}
		}
	}

	private function configureAnimations()
	{
		animation.add("idle", [0], 1.0, true);
		animation.add("talk", [0, 1], 8.0, true);

		animation.play("idle");
	}
}
