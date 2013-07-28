//Code generated with DAME. http://www.dambots.com

package pl.filipszu.tbbs.maps
{
	import org.flixel.*;
	public class Level_Level1 extends Level_proto
	{
		//Embedded media...
		[Embed(source="../csv/mapCSV_Main_Level1.csv", mimeType="application/octet-stream")] public var CSV_MainLevel1:Class;
		[Embed(source="../../../../assets/platform_tiles_1.png")] public var Img_MainLevel1:Class;

		//Tilemaps
		public var layerMainLevel1:FlxTilemap;

		//Sprites


		public function Level_Level1(addToStage:Boolean = false, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerMainLevel1 = new FlxTilemap;
			layerMainLevel1.loadMap( new CSV_MainLevel1, Img_MainLevel1, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerMainLevel1.x = 0.000000;
			layerMainLevel1.y = 0.000000;
			layerMainLevel1.scrollFactor.x = 1.000000;
			layerMainLevel1.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerMainLevel1);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerMainLevel1;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 400;
			boundsMaxY = 192;

			setNestPoint();
			setBirthPoints();
			MAX_WORMS_CATCH = birthPlaces.length;
		}
		
		private function setBirthPoints():void{
			var b1:FlxPoint = new FlxPoint(183, 176);
			birthPlaces.push(b1);
			
			var b2:FlxPoint = new FlxPoint(250, 176);
			birthPlaces.push(b2);
			
		}
		
		private function setNestPoint():void{
			nestPoint.x = 16;
			nestPoint.y = 112;
		}		


	}
}
