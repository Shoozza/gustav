package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import flash.system.System;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.LogitechButtonID;
import haxe.Timer;

class MenuState extends FlxState
{
	private var start:FlxText;
	private var options:FlxText;
	private var exit:FlxText;
	private var menu:Array<FlxText>;

	private var canvas:FlxSprite;
	private var logo:FlxSprite;

	private var index:Int;
	private var _gamePad:FlxGamepad;
	private var _timer:Timer;
	private var _oldDown:Bool;
	private var _oldUp:Bool;
	private var _down:Bool;
	private var _up:Bool;
	private var _justDown:Bool;
	private var _justUp:Bool;
	private var _direction:Float;

	override public function create():Void
	{
		super.create();

		_oldDown = _oldUp = _up = _down = false;

		_gamePad = FlxG.gamepads.lastActive;

		_timer = new haxe.Timer(100);
		_timer.run = function()
		{
			if (_gamePad == null)
			{
				_gamePad = FlxG.gamepads.lastActive;
			}

			if (_gamePad != null)
			{
				_timer.stop();
			}
		};

		logo = new FlxSprite();
		logo.loadGraphic("assets/images/logo.png");
		logo.x = (FlxG.width - logo.width) / 2;
		add(logo);

		this.bgColor = 0x00000000;
		menu = new Array<FlxText>();

		start   = new FlxText(0, FlxG.height/5*2 + FlxG.height/7, FlxG.width, "Start", 52);
		options = new FlxText(0, FlxG.height/5*2 + FlxG.height/7*2, FlxG.width, "Options", 52);
		exit    = new FlxText(0, FlxG.height/5*2 + FlxG.height/7*3, FlxG.width, "Exit", 52);
		start.setFormat(null, 52, 0xffffff, "center", FlxText.BORDER_OUTLINE, 0x000000);
		options.setFormat(null, 52, 0xffffff, "center", FlxText.BORDER_OUTLINE, 0x000000);
		exit.setFormat(null, 52, 0xffffff, "center", FlxText.BORDER_OUTLINE, 0x000000);

		menu.push(start);
		menu.push(options);
		menu.push(exit);

		canvas = new FlxSprite(0, 0);
		canvas.makeGraphic(40, 40, FlxColor.TRANSPARENT, true);
		FlxSpriteUtil.drawTriangle(canvas, 0, 0, 40, 0xFFFFFFFF, { color: FlxColor.WHITE, thickness: 1 },
			{ color: FlxColor.WHITE, alpha: 0.5 });
		canvas.angle = 90;
		canvas.x = start.x - 60;
		canvas.y = start.y + 10;
		add(canvas);

		for (e in menu)
			add(e);

		index = 0;

		canvas.y = menu[index].y + 10;
		canvas.x = menu[index].x + 200;

		FlxG.mouse.visible = false;
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();

		if (_gamePad != null)
		{
			_up = _gamePad.getXAxis(LogitechButtonID.LEFT_ANALOGUE_Y) < 0;
			_justUp = !_oldUp && _up;
			_down = _gamePad.getXAxis(LogitechButtonID.LEFT_ANALOGUE_Y) > 0;
			_justDown = !_oldDown && _down;
			_oldUp = _up;
			_oldDown = _down;
		}

		if (FlxG.keys.justPressed.DOWN || _justDown)
		{
			index = (index + 1) % 3;
			canvas.y = menu[index].y + 10;
			canvas.x = menu[index].x + 200;
		}
		if (FlxG.keys.justPressed.UP || _justUp)
		{
			index = (index + 2) % 3;
			canvas.y = menu[index].y + 10;
			canvas.x = menu[index].x + 200;
		}
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE ||
			(_gamePad != null &&
			_gamePad.anyJustPressed([
				LogitechButtonID.ONE,
				LogitechButtonID.TWO,
				LogitechButtonID.THREE,
				LogitechButtonID.FOUR])
			))
		{
			if (index == 0)
			{
				_timer.stop();
				FlxG.switchState(new CutSceneState());
			}
			if (index == 1)
			{
				trace("todo");
				_timer.stop();
				//FlxG.switchState(new OptionsState());
			}
			if (index == 2)
			{
				_timer.stop();
				System.exit(0);
			}
		}
	}
}
