package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class MenuState extends FlxState
{
	override public function create():Void
	{
		super.create();
		this.bgColor = 0x00000000;
		add(new FlxText(0, 0, 100, "Menu"));
		FlxG.mouse.visible = false;
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		//FlxG.switchState(new PlayState());
		FlxG.switchState(new CutSceneState());
	}
}
