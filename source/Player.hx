package;

import flixel.FlxSprite;
import flixel.FlxG;

class Player extends FlxSprite
{
	private static inline var SPEED = 4;

	public function new(X, Y)
	{
		super(X, Y);
		loadGraphic("assets/images/player.png", false, 48, 48);
		animation.add("up", [0]);
		animation.add("left", [1]);
		animation.add("down", [2]);
		animation.add("right", [3]);
		animation.play("up");
	}

	override public function update():Void
	{
		super.update();
		if (FlxG.keys.pressed.LEFT) {
			if (!FlxG.keys.pressed.SHIFT)
				animation.play("left");
			x -= SPEED;
		}
		else if (FlxG.keys.pressed.RIGHT) {
			if (!FlxG.keys.pressed.SHIFT)
				animation.play("right");
			x += SPEED;
		}

		if (FlxG.keys.pressed.UP) {
			if (!FlxG.keys.pressed.SHIFT)
				animation.play("up");
			y -= SPEED;
		}
		else if (FlxG.keys.pressed.DOWN) {
			if (!FlxG.keys.pressed.SHIFT)
				animation.play("down");
			y += SPEED;
		}
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
