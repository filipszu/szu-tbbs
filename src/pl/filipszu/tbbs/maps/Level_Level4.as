//Code generated with DAME. http://www.dambots.com

package pl.filipszu.tbbs.maps
{
	import org.flixel.*;
	public class Level_Level4 extends Level_proto
	{
		//Embedded media...
		[Embed(source="../csv/mapCSV_Main_Level4.csv", mimeType="application/octet-stream")] public var CSV_MainLevel4:Class;
		[Embed(source="../../../../assets/platform_tiles_1.png")] public var Img_MainLevel4:Class;

		//Tilemaps
		public var layerMainLevel4:FlxTilemap;

		//Sprites


		public function Level_Level4(addToStage:Boolean = false, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerMainLevel4 = new FlxTilemap;
			layerMainLevel4.loadMap( new CSV_MainLevel4, Img_MainLevel4, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerMainLevel4.x = 0.000000;
			layerMainLevel4.y = 0.000000;
			layerMainLevel4.scrollFactor.x = 1.000000;
			layerMainLevel4.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerMainLevel4);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerMainLevel4;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 400;
			boundsMaxY = 384;
			setNestPoint();
			setBirthPoints();
			MAX_WORMS_CATCH = birthPlaces.length;
		}
		
		private function setBirthPoints():void{
			var b1:FlxPoint = new FlxPoint(8, 256);
			birthPlaces.push(b1);
			var b2:FlxPoint = new FlxPoint(334, 320);
			birthPlaces.push(b2);
			var b3:FlxPoint = new FlxPoint(177, 368);
			birthPlaces.push(b3);
			var b4:FlxPoint = new FlxPoint(37, 368);
			birthPlaces.push(b4);
		}
		
		private function setNestPoint():void{
			nestPoint.x = 315;
			nestPoint.y = 64;
		}		


	}
}
