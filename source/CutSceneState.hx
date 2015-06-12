package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.VarTween;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.LogitechButtonID;
import haxe.Timer;

class CutSceneState extends FlxState
{
	private var _background:FlxSprite;
	private var _textbox:FlxSprite;
	private var _grandpa:FlxSprite;
	private var _people:FlxSprite;
	private var _index:Int;
	private var _needsUpdate:Bool;
	private var _text:FlxText;
	private var _grandpaTween:VarTween;
	private var _peopleTween:VarTween;
	private var _startpos:Float;
	private var _justAny:Bool;
	private var _justEscape:Bool;
	private var _gamePad:FlxGamepad;
	private var _timer:Timer;

	override public function create():Void
	{
		super.create();

		_gamePad = FlxG.gamepads.lastActive;
		_justAny = false;
		_justEscape = false;

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

		_background = new FlxSprite();
		_background.loadGraphic("assets/images/cutscenebackground.png");
		_startpos = (FlxG.width - _background.width) / 2;
		_background.x = _startpos;
		_background.y = 0;
		add(_background);

		_grandpa = new FlxSprite();
		_grandpa.loadGraphic("assets/images/grandpa0.png");
		_grandpa.x = _startpos;
		_grandpa.y = 0;
		add(_grandpa);
		_grandpa.kill();

		_people = new FlxSprite();
		_people.loadGraphic("assets/images/people0.png");
		_people.x = _startpos;
		_people.y = 0;
		add(_people);
		_people.kill();

		_textbox = new FlxSprite();
		_textbox.loadGraphic("assets/images/cutscenetextbox.png");
		_textbox.x = _startpos;
		_textbox.y = 0;
		add(_textbox);

		add(new FlxText(0, 0, 100, "Cut"));

		_text = new FlxText(0, FlxG.height - FlxG.height/8, FlxG.width);
		_text.setFormat(null, 12, 0xffffff, "center", FlxText.BORDER_OUTLINE, 0x000000);
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
						_grandpa.kill();
						_people.reset(_startpos, 0);
						_peopleTween = FlxTween.tween(_people, { x: _startpos - FlxG.width/20 }, 5.0);
						_text.text = "graddady you'll die soon, so sorry. can we has your money bro?";
					}
				case 1:
					{
						_peopleTween.cancel();
						_people.kill();
						_grandpa.reset(_startpos, 0);
						_grandpa.x = _startpos;
						_grandpaTween = FlxTween.tween(_grandpa, { x: _startpos + FlxG.width/20 }, 5.0);
						_text.text = "wat? i will die, cant be true-value.";
					}
				case 2:
					{
						_grandpaTween.cancel();
						_grandpa.kill();
						_people.reset(_startpos, 0);
						_peopleTween = FlxTween.tween(_people, { x: _startpos - FlxG.width/20 }, 5.0);
						_text.text = "you betta beliv it. we just asked the docs dudes.";
					}
				case 3:
					{
						_peopleTween.cancel();
						_people.kill();
						_grandpa.reset(_startpos, 0);
						_grandpa.x = _startpos;
						_grandpaTween = FlxTween.tween(_grandpa, { x: _startpos + FlxG.width/20 }, 5.0);
						_text.text = "nope, do not want, dying double mainstream 4 me.";
					}
				case 4:
					{
						_grandpaTween.cancel();
						_grandpa.kill();
						_people.reset(_startpos, 0);
						_peopleTween = FlxTween.tween(_people, { x: _startpos - FlxG.width/20 }, 5.0);
						_text.text = "what do ya meaning? you talk gibberisz";
					}
				case 5:
					{
						_peopleTween.cancel();
						_people.kill();
						_grandpa.reset(_startpos, 0);
						_grandpa.x = _startpos;
						_grandpaTween = FlxTween.tween(_grandpa, { x: _startpos + FlxG.width/20 }, 5.0);
						_text.text = "deal with it, ill become invincible ma boi, engage!";
					}
				case 6:
					{
						_timer.stop();
						FlxG.switchState(new PlayState());
					}
			}
		}
		if (_gamePad != null)
		{
			_justAny = _gamePad.anyJustPressed([
				LogitechButtonID.ONE,
				LogitechButtonID.TWO,
				LogitechButtonID.THREE,
				LogitechButtonID.FOUR,
				LogitechButtonID.FIVE,
				LogitechButtonID.SIX,
				LogitechButtonID.SEVEN,
				LogitechButtonID.EIGHT,
				LogitechButtonID.NINE,
				LogitechButtonID.TEN]);
			_justEscape = _gamePad.anyJustPressed([
				LogitechButtonID.NINE,
				LogitechButtonID.TEN]);
		}
		if (FlxG.keys.justPressed.ESCAPE || _justEscape)
		{
			_needsUpdate = true;
			_index = 6;
		}
		else if (FlxG.keys.justPressed.ANY || _justAny)
		{
			_needsUpdate = true;
			_index = _index + 1;
		}

	}
}
