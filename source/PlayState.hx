package;

import flixel.FlxState;
import flixel.FlxG;
import haxe.io.Path;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;

class PlayState extends FlxState
{
	private var player:Player;
	private var collidableTileLayers:Array<FlxTilemap>;

	override public function create():Void
	{
		super.create();

		var tiledLevel:TiledMap = new TiledMap("assets/data/hospital.tmx");

		var tileSize = tiledLevel.tileWidth;
		var mapW = tiledLevel.width;
		var mapH = tiledLevel.height;

		collidableTileLayers = new Array<FlxTilemap>();

		for (layer in tiledLevel.layers)
		{
			// for csv output
			//var layerData:String = layer.csvData;

			var layerData:Array<Int> = layer.tileArray;

			var tilesheetName:String = layer.properties.get("tilesheet");
			var tilesheetPath:String = "assets/images/" + tilesheetName;


			var level:FlxTilemap = new FlxTilemap();

			level.widthInTiles = mapW;
			level.heightInTiles = mapH;

			var tileGID:Int = getStartGid(tiledLevel, tilesheetName);

			level.loadMap(layer.tileArray, tilesheetPath, tileSize, tileSize, FlxTilemap.OFF, tileGID);

			if (layer.properties.contains("collide"))
			{
				collidableTileLayers.push(level);
			}
			add(level);
		}

		for (group in tiledLevel.objectGroups)
		{
			for (o in group.objects)
			{
				switch (o.type.toLowerCase())
				{
					case "player_start":
						player = new Player(o.x, o.y);
						add(player);
				}
			}
		}
	}

	function getStartGid (tiledLevel:TiledMap, tilesheetName:String):Int
	{
		var tileGID:Int = 1;

		for (tileset in tiledLevel.tilesets)
		{
			var tilesheetPath:Path = new Path(tileset.imageSource);
			var thisTilesheetName = tilesheetPath.file + "." + tilesheetPath.ext;
			if (thisTilesheetName == tilesheetName)
			{
				tileGID = tileset.firstGID;
			}
		}

		return tileGID;
	}

	override public function update():Void
	{
		super.update();
		for (layer in collidableTileLayers)
		{
			//FlxG.overlap(player, layer);
			FlxG.collide(player, layer);
		}
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
