package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.tweens.FlxTween;

class CutSceneState extends FlxState
{
	private var _background:FlxSprite;
	private var _grandpa:FlxSprite;
	private var _people:FlxSprite;
	private var _index:Int;
	private var _needsUpdate:Bool;
	private var _text:FlxText;

	override public function create():Void
	{
		super.create();

		_background = new FlxSprite();
		_background.loadGraphic("assets/images/cutscenebackground.png");
		_background.x = 0;
		_background.y = 0;
		add(_background);

		_grandpa = new FlxSprite();
		_grandpa.loadGraphic("assets/images/grandpa0.png");
		_grandpa.x = 0;
		_grandpa.y = 0;
		add(_grandpa);
		_grandpa.kill();

		_people = new FlxSprite();
		_people.loadGraphic("assets/images/people0.png");
		_people.x = 0;
		_people.y = 0;
		add(_people);
		_people.kill();

		add(new FlxText(0, 0, 100, "Cut"));

		_text = new FlxText(FlxG.width/2, FlxG.height - FlxG.height/10);
		add(_text);

		_index = 0;
		_needsUpdate = true;
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		if (_needsUpdate)
		{
			_needsUpdate = false;
			switch(_index)
			{
				case 0:
					{
						_grandpa.reset(0, 0);
						FlxTween.tween(_grandpa, { x: FlxG.width/10 }, 5.0);
						_people.kill();
						_text.text = "blablah";
					}
				case 1:
					{
						_grandpa.kill();
						_people.reset(0, 0);
						FlxTween.tween(_people, { x: -FlxG.width/10 }, 5.0);
						_text.text = "hmm yeah ok hmm";
					}
				case 2:
					{
						_grandpa.reset(0, 0);
						FlxTween.tween(_grandpa, { x: FlxG.width/10 }, 5.0);
						_people.kill();
						_text.text = "nonononono never - denied";
					}
				case 3:
					{
						FlxG.switchState(new PlayState());
					}
			}
		}
		if (FlxG.keys.justPressed.ANY)
		{
			_needsUpdate = true;
			_index = _index + 1;
		}

	}
}
