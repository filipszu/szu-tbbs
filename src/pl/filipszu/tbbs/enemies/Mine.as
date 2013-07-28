package pl.filipszu.tbbs.enemies{
	import org.flixel.FlxSprite;
	import pl.filipszu.tbbs.model.GameModel;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxMath;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Mine extends FlxSprite{
		
		public static const WIDTH:Number = 11;
		public static const HEIGHT:Number = 11;
		
		public const ANIM_FLASH:String = 'flash';
		public const ANIM_STOP:String = 'stop';
		
		[Embed(source="../../../../assets/birthPlace.png")] private var BIRTH_PLACE:Class;
		private var model:GameModel = GameModel.getInstance();
		public var inCamera:Boolean = false;
		
		public function Mine(X:Number=0, Y:Number=0){
			super(X, Y, null);
			makeGraphics();
			play(ANIM_STOP);			
		}
		
		private function makeGraphics():void{
			makeGraphic(50, 50, 0xFFFFFFFF);
			loadGraphic(BIRTH_PLACE, true, false, 11, 11, true);
			addAnimation(ANIM_FLASH, [0, 1], 5, true);
			addAnimation(ANIM_STOP, [0], 0, false);
		}
		
		override public function update():void{
			super.update();
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