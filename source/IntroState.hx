package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

/**
 * A FlxState which can be used for the game's menu.
 */
class IntroState extends FlxState
{
	private var _logo:FlxSprite;
	private var _publisher:FlxSprite;
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		add(new FlxText(0, 0, 100, "Intro"));
		this.bgColor = 0xFFFFFFFF;
		FlxG.mouse.visible = false;
		_logo = new FlxSprite();
		_logo.loadGraphic("assets/images/intrologo.png");
		_logo.x = (FlxG.width  - _logo.width)  / 2;
		_logo.y = (FlxG.height - _logo.height) / 2;
		_logo.alpha = 0.0;
		add(_logo);

		_publisher= new FlxSprite();
		_publisher.loadGraphic("assets/images/intropublisher.png");
		_publisher.x = (FlxG.width  - _publisher.width)  / 2;
		_publisher.y = (FlxG.height - _publisher.height) / 2;
		_publisher.alpha = 0.0;
		add(_publisher);

		FlxTween.tween(_logo, {alpha: 1.0}, 0.25, { type: FlxTween.PINGPONG, ease:FlxEase.quadInOut, loopDelay: 1, complete: function(tween:FlxTween) {
				if (_logo.alpha == 0.0)
				{
					tween.cancel();
					FlxTween.tween(_publisher, {alpha: 1.0}, 0.25, { type: FlxTween.ONESHOT, ease:FlxEase.quadInOut, loopDelay: 1, complete: function(tween:FlxTween) {
							Sys.sleep(1);
							switchState();
							}});
				}
				}});
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	private function switchState():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.25, false, function(){
				FlxG.camera.fill(0);
				FlxG.switchState(new MenuState());
				});
	}
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		if (FlxG.keys.justPressed.SPACE)
		{
			switchState();
		}
	}
}
