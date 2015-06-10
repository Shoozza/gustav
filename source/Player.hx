package;

import flixel.FlxSprite;
import flixel.FlxG;

class Player extends FlxSprite
{
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
			x += -2;
		}
		else if (FlxG.keys.pressed.RIGHT) {
			if (!FlxG.keys.pressed.SHIFT)
				animation.play("right");
			x +=  2;
		}
		else if (FlxG.keys.pressed.UP) {
			if (!FlxG.keys.pressed.SHIFT)
				animation.play("up");
			y += -2;
		}
		else if (FlxG.keys.pressed.DOWN) {
			if (!FlxG.keys.pressed.SHIFT)
				animation.play("down");
			y +=  2;
		}
		else {
			//velocity.x =  0;
			//velocity.y =  0;
		}
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
