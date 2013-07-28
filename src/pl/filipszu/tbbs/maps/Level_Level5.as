//Code generated with DAME. http://www.dambots.com

package pl.filipszu.tbbs.maps
{
	import org.flixel.*;
	public class Level_Level5 extends Level_proto
	{
		//Embedded media...
		[Embed(source="../csv/mapCSV_Main_Level5.csv", mimeType="application/octet-stream")] public var CSV_MainLevel5:Class;
		[Embed(source="../../../../assets/platform_tiles_1.png")] public var Img_MainLevel5:Class;

		//Tilemaps
		public var layerMainLevel5:FlxTilemap;

		//Sprites


		public function Level_Level5(addToStage:Boolean = false, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerMainLevel5 = new FlxTilemap;
			layerMainLevel5.loadMap( new CSV_MainLevel5, Img_MainLevel5, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerMainLevel5.x = 0.000000;
			layerMainLevel5.y = 0.000000;
			layerMainLevel5.scrollFactor.x = 1.000000;
			layerMainLevel5.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerMainLevel5);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerMainLevel5;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 800;
			boundsMaxY = 384;
			setNestPoint();
			setBirthPoints();
			MAX_WORMS_CATCH = birthPlaces.length;
		}
		
		private function setBirthPoints():void{
			var b1:FlxPoint = new FlxPoint(222, 80);
			birthPlaces.push(b1);
			var b2:FlxPoint = new FlxPoint(93, 368);
			birthPlaces.push(b2);
			var b3:FlxPoint = new FlxPoint(172, 320);
			birthPlaces.push(b3);
			var b4:FlxPoint = new FlxPoint(300, 368);
			birthPlaces.push(b4);
			var b5:FlxPoint = new FlxPoint(492, 368);
			birthPlaces.push(b5);
			var b6:FlxPoint = new FlxPoint(748, 208);
			birthPlaces.push(b6);
			var b7:FlxPoint = new FlxPoint(715, 368);
			birthPlaces.push(b7);
			/*
			var b2:FlxPoint = new FlxPoint(176, 368);
			birthPlaces.push(b2);
			*/
		}
		
		private function setNestPoint():void{
			nestPoint.x = 19;
			nestPoint.y = 64;
		}		


	}
}
