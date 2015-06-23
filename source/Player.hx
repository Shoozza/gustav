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

	private var _left:Bool;
	private var _right:Bool;
	private var _up:Bool;
	private var _down:Bool;
	private var _strafe:Bool;

	private var _padLeft:Bool;
	private var _padRight:Bool;
	private var _padUp:Bool;
	private var _padDown:Bool;
	private var _padStrafe:Bool;

	private function move()
	{
		if (_left || _padLeft)
		{
			if (!(_strafe || _padStrafe))
				animation.play("left");
			x -= SPEED;
		}
		if (_right || _padRight)
		{
			if (!(_strafe || _padStrafe))
				animation.play("right");
			x += SPEED;
		}
		if (_up || _padUp)
		{
			if (!(_strafe || _padStrafe))
				animation.play("up");
			y -= SPEED;
		}
		if (_down || _padDown)
		{
			if (!(_strafe || _padStrafe))
				animation.play("down");
			y += SPEED;
		}
	}

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

		_gamePad = FlxG.gamepads.lastActive;
		if (_gamePad == null)
		{
			trace("failed to find gamepad");
		}
	}

	private function gamepadControls():Void
	{
		_padStrafe = _gamePad.pressed(LogitechButtonID.SEVEN);

		_direction = _gamePad.getXAxis(LogitechButtonID.LEFT_ANALOGUE_X);
		_padLeft   = _direction < 0;
		_padRight  = _direction > 0;

		_direction = _gamePad.getYAxis(LogitechButtonID.LEFT_ANALOGUE_Y);
		_padUp     = _direction < 0;
		_padDown   = _direction > 0;
	}

	override public function update():Void
	{
		super.update();
		_strafe = FlxG.keys.pressed.SHIFT;

		_left = FlxG.keys.pressed.LEFT;
		_right = FlxG.keys.pressed.RIGHT;

		_up = FlxG.keys.pressed.UP;
		_down = FlxG.keys.pressed.DOWN;

		if (_gamePad != null)
		{
			gamepadControls();
		}

		move();
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
