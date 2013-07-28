package pl.filipszu.tbbs.player
{
	import org.flixel.FlxSprite;
	
	public class Nest_proto extends FlxSprite
	{
		public static const WIDTH:Number = 41;
		public static const HEIGHT:Number = 16;
		
		public const OPEN:String = 'open';
		
		[Embed(source="../../../../assets/nest.png")] private var NEST:Class;
		public var rotated:Boolean = false;
		
		public function Nest_proto(X:Number=0, Y:Number=0){
			super(X, Y);
			makeGraphics();
			
			angle = 90;
			this.width = 41;
			this.height = 16;
			this.offset.x = -20;
			this.offset.y = 23;
			this.x = X;
			this.y = Y - height;
			
		
			
		}
		private function makeGraphics():void{
			loadGraphic(NEST, true, false, 16, 63, true);
			addAnimation(OPEN, [0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 0], 10, false);
		}
	}
}