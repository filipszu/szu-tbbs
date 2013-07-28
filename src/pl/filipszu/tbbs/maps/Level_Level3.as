//Code generated with DAME. http://www.dambots.com

package pl.filipszu.tbbs.maps
{
	import org.flixel.*;
	public class Level_Level3 extends Level_proto
	{
		//Embedded media...
		[Embed(source="../csv/mapCSV_Main_Level3.csv", mimeType="application/octet-stream")] public var CSV_MainLevel3:Class;
		[Embed(source="../../../../assets/platform_tiles_1.png")] public var Img_MainLevel3:Class;

		//Tilemaps
		public var layerMainLevel3:FlxTilemap;

		//Sprites


		public function Level_Level3(addToStage:Boolean = false, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerMainLevel3 = new FlxTilemap;
			layerMainLevel3.loadMap( new CSV_MainLevel3, Img_MainLevel3, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerMainLevel3.x = 0.000000;
			layerMainLevel3.y = 0.000000;
			layerMainLevel3.scrollFactor.x = 1.000000;
			layerMainLevel3.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerMainLevel3);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerMainLevel3;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 800;
			boundsMaxY = 192;
			setNestPoint();
			setBirthPoints();
			MAX_WORMS_CATCH = birthPlaces.length;
		}
		
		private function setBirthPoints():void{
			var b1:FlxPoint = new FlxPoint(131, 176);
			birthPlaces.push(b1);
			
			var b2:FlxPoint = new FlxPoint(322, 176);
			birthPlaces.push(b2);
			
			var b3:FlxPoint = new FlxPoint(450, 176);
			birthPlaces.push(b3);
			
			var b4:FlxPoint = new FlxPoint(550, 176);
			birthPlaces.push(b4);
			
			var b5:FlxPoint = new FlxPoint(100, 100);
			birthPlaces.push(b5);
		}
		
		private function setNestPoint():void{
			nestPoint.x = 13;
			nestPoint.y = 48;
		}		


	}
}
