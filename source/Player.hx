package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.LogitechButtonID;

class Player extends FlxSprite
{
	private static inline var SPEED = 4;
	private var _gamePad:FlxGamepad;
	private var _direction:Float;
	private var _strafe:Bool;

	public function new(X, Y)
	{
		super(X, Y);
		loadGraphic("assets/images/player.png", false, 48, 48);
		animation.add("up", [0]);
		animation.add("left", [1]);
		animation.add("down", [2]);
		animation.add("right", [3]);
		animation.play("up");

		_gamePad = FlxG.gamepads.lastActive;
		if (_gamePad == null)
		{
			trace("failed to find gamepad");
		}
	}

	private function gamepadControls():Void
	{
		_strafe = _gamePad.pressed(LogitechButtonID.SEVEN);

		_direction = _gamePad.getXAxis(LogitechButtonID.LEFT_ANALOGUE_X);
		if (_direction != 0)
		{
			if (_direction < 0)
			{
				if (!_strafe)
					animation.play("left");
				x -= SPEED;
			}
			else
			{
				if (!_strafe)
					animation.play("right");
				x += SPEED;
			}
		}
		_direction = _gamePad.getYAxis(LogitechButtonID.LEFT_ANALOGUE_Y);
		if (_direction != 0)
		{
			if (_direction < 0)
			{
				if (!_strafe)
					animation.play("up");
				y -= SPEED;
			}
			else
			{
				if (!_strafe)
					animation.play("down");
				y += SPEED;
			}
		}
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

		if (_gamePad != null)
		{
			gamepadControls();
		}
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
