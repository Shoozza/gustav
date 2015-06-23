package;

import flixel.FlxSprite;
import flixel.FlxG;

class Enemy extends FlxSprite
{
	private static inline var SPEED = 4;

	public function new(X, Y, H)
	{
		super(X, Y);
		loadGraphic("assets/images/player.png", false, 48, 48);
		animation.add("up", [0]);
		animation.add("left", [1]);
		animation.add("down", [2]);
		animation.add("right", [3]);
		animation.play("up");
		offset.set(0, 48-H);
		height = H;
	}

	override public function update():Void
	{
		super.update();
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
