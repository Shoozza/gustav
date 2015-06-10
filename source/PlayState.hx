package;

import flixel.FlxState;
import flixel.FlxG;
import haxe.io.Path;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();

		var tiledLevel:TiledMap = new TiledMap("assets/data/hospital.tmx");

		var tileSize = tiledLevel.tileWidth;
		var mapW = tiledLevel.width;
		var mapH = tiledLevel.height;

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
			add(level);
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
	}

	override public function destroy():Void
	{
		super.destroy();
	}
}
