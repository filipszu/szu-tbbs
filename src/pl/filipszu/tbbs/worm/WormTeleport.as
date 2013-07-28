package  pl.filipszu.tbbs.worm{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import pl.filipszu.tbbs.model.GameModel;
	
	public class WormTeleport extends FlxSprite {
		
		public static const WIDTH:Number = 25;
		public static const HEIGHT:Number = 19;
		
		public const ANIM_TELEPORT_IN:String = 'teleport_in';
		public const ANIM_TELEPORT_OUT:String = 'teleport_out';
		
		[Embed(source="../../../../assets/wormTeleport.png")] private var WORM_TELEPORT:Class;
		private var model:GameModel = GameModel.getInstance();
		public var inCamera:Boolean = false;
		public var saw:Boolean = false;
		public var animating:Boolean = false;
		public function WormTeleport(X:Number=0, Y:Number=0) {
			super(X-12.5, Y - 8.5, null);
			makeGraphics();
			frame = 4;
			//play('teleport_in');
		}
		
		override public function play(AnimName:String, Force:Boolean = false):void{
			animating = true;
			super.play(AnimName, Force);
		}
		
		private function makeGraphics():void{
			loadGraphic(WORM_TELEPORT, true, true, 25, 19, true);
			addAnimation(ANIM_TELEPORT_IN, [4, 3, 2, 1, 0], 10, false);
			addAnimation(ANIM_TELEPORT_OUT, [0, 1, 2, 3, 4], 10, false);
		}
		
		override public function update():void{
			super.update();
			
			if(animating && finished){
				animating = false;
				kill();
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
