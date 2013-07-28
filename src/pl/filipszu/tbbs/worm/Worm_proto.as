package pl.filipszu.tbbs.worm
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import pl.filipszu.tbbs.model.GameModel;
	import org.flixel.FlxG;
	
	public class Worm_proto extends FlxSprite
	{
		public static const WIDTH:Number = 18;
		public static const HEIGHT:Number = 19;
		
		public const ANIM_WALK:String = 'walk';
		
		[Embed(source="../../../../assets/worm.png")] private var WORM:Class;
		private var model:GameModel = GameModel.getInstance();
		private var maxSpeed:Number = 50;
		public var teleport:WormTeleport;
		public var inCamera:Boolean = false;
		
		public function Worm_proto(X:Number=0, Y:Number=0){
			super(X, Y, null);
			makeGraphics();
			width = 14;
			height = 15;
			offset.x = 2;
			offset.y = 4;
			x+=2;
			y+=4;
			play(ANIM_WALK);
		}
		
		private function makeGraphics():void{
			loadGraphic(WORM, true, true, 18, 19, true);
			addAnimation(ANIM_WALK, [0, 1, 2, 0], 10, true);
		}
		
		override public function update():void{
			super.update();
			if(velocity.x > 0){
				facing = FlxObject.LEFT;
			}
			if(velocity.x < 0){
				facing = FlxObject.RIGHT;
			}
			if(y > FlxG.camera.scroll.y && 
			   y < FlxG.camera.scroll.y + model.viewBounds.height &&
			   x > FlxG.camera.scroll.x && 
			   x < FlxG.camera.scroll.x + model.viewBounds.width){
				inCamera = true;
			}else{
				inCamera = false;
			}
		}
		
	}
}