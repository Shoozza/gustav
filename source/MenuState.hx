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

class MenuState extends FlxState
{
	private var start:FlxText;
	private var options:FlxText;
	private var exit:FlxText;
	private var menu:Array<FlxText>;

	private var canvas:FlxSprite;
	private var index:Int;

	override public function create():Void
	{
		super.create();
		this.bgColor = 0x00000000;
		menu = new Array<FlxText>();

		start   = new FlxText(0, FlxG.height/4, FlxG.width, "Start", 52);
		options = new FlxText(0, FlxG.height/4*2, FlxG.width, "Options", 52);
		exit    = new FlxText(0, FlxG.height/4*3, FlxG.width, "Exit", 52);
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
		canvas.x = menu[index].x + 100;

		FlxG.mouse.visible = false;
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();

		if (FlxG.keys.justPressed.DOWN)
		{
			index = (index + 1) % 3;
			canvas.y = menu[index].y + 10;
			canvas.x = menu[index].x + 100;
		}
		if (FlxG.keys.justPressed.UP)
		{
			index = (index + 2) % 3;
			canvas.y = menu[index].y + 10;
			canvas.x = menu[index].x + 100;
		}
		if (FlxG.keys.justPressed.ENTER)
		{
			if (index == 0)
				FlxG.switchState(new CutSceneState());
			if (index == 1)
				trace("todo");
				//FlxG.switchState(new OptionsState());
			if (index == 2)
				System.exit(0);
		}
	}
}
