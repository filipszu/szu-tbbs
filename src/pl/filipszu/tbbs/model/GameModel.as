package pl.filipszu.tbbs.model {
	import flash.geom.Rectangle;
	
	import org.flixel.FlxPoint;
	
	import pl.filipszu.tbbs.maps.Level_Level1;
	import pl.filipszu.tbbs.maps.Level_Level2;
	import pl.filipszu.tbbs.maps.Level_Level3;
	import pl.filipszu.tbbs.maps.Level_Level4;
	import pl.filipszu.tbbs.maps.Level_Level5;
	import pl.filipszu.tbbs.maps.Level_proto;
	import pl.filipszu.tbbs.player.Player;
	
	public class GameModel {
		
		public var time:Number = 0;
		
		private function doubleDigitFormat($num:uint):String{
			if ($num < 10) 
			{
				return ("0" + $num);
			}
			return String($num);
		}
		
		public function timeString():String{
			var $seconds:int = Math.floor(time);
			var s:Number = $seconds % 60;
			var m:Number = Math.floor(($seconds % 3600 ) / 60);
			var h:Number = Math.floor($seconds / (60 * 60));
			
			var hourStr:String = (h == 0) ? "" : doubleDigitFormat(h) + ":";
			var minuteStr:String = doubleDigitFormat(m) + ":";
			var secondsStr:String = doubleDigitFormat(s);
			
			return hourStr + minuteStr + secondsStr;
		}
		
		public var player:Player;
		public var currentLevelIndex:uint = 0;
		public var level:Level_proto;
		public var currentPoints:uint = 0;
		private static var _instance:GameModel=null;
		
		public const viewBounds:Rectangle = new Rectangle(0, 0, 400, 200);
		public const maxLandingSpeed:Number = 150;
		public const WORM_SPEED:Number = 10;
		
		public const levels:Array = [
									  {name: 'Level1', levelClass: Level_Level1},
									  {name: 'Level2', levelClass: Level_Level2},
									  {name: 'Level3', levelClass: Level_Level3},
									  {name: 'Level4', levelClass: Level_Level4},
									  {name: 'Level5', levelClass: Level_Level5}
									  ];
		public function GameModel(e:SingletonEnforcer) {
			
		}
		public static function getInstance():GameModel{
            if(_instance==null){
                _instance=new GameModel(new SingletonEnforcer());
            }
            return _instance;
        }
	}
}
class SingletonEnforcer{}	

