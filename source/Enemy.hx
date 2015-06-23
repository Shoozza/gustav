package;

import flixel.FlxSprite;
import flixel.FlxG;
import openfl.Assets;

class Enemy extends FlxSprite
{
	private static inline var SPEED = 4;

	public function new(X, Y, H)
	{
		super(X, Y);
		var widthInt = 48;
		var heightInt = 48;

		var basePath:String = "assets/images/";
		var baseXmlPath:String = "assets/data/";

		var xmlFileName:String = "enemy.xml";
		var fileName:String = "enemy.png";
		try
		{
			if (Assets.exists(baseXmlPath + xmlFileName))
			{
				var playerXml:String = Assets.getText(baseXmlPath + xmlFileName);
				var root:Xml = Xml.parse(playerXml).firstElement();

				var imageNameStr:String = root.get('src');
				if (imageNameStr!= null)
				{
					fileName = imageNameStr;
				}

				var widthStr:String = root.get('width');
				if (widthStr != null)
				{
					widthInt = Std.parseInt(widthStr);
				}

				var heightStr:String = root.get('height');
				if (heightStr != null)
				{
					heightInt = Std.parseInt(heightStr);
				}
			}
		}
		catch (unknown : Dynamic)
		{
		}

		loadGraphic(basePath + fileName, false, widthInt, heightInt);
		animation.add("up", [0]);
		animation.add("left", [1]);
		animation.add("down", [2]);
		animation.add("right", [3]);
		animation.play("up");
		offset.set(0, heightInt-H);
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
