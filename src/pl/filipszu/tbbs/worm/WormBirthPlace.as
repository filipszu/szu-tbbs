package pl.filipszu.tbbs.worm{
	import org.flixel.FlxSprite;
	import pl.filipszu.tbbs.model.GameModel;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxMath;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class WormBirthPlace extends FlxSprite{
		
		public static const WIDTH:Number = 11;
		public static const HEIGHT:Number = 11;
		
		public const ANIM_FLASH:String = 'flash';
		public const ANIM_STOP:String = 'stop';
		
		[Embed(source="../../assets/birthPlace.png")] private var BIRTH_PLACE:Class;
		private var model:GameModel = GameModel.getInstance();
		public var worm:Worm_proto;
		public var full:Boolean = false;
		public var teleport:WormTeleport;
		public var inCamera:Boolean = false;
		public var respawnTimer:Timer;
		public var respawnTime:Boolean = false;
		public var teleportPlayed:Boolean = false;
		
		public function WormBirthPlace(X:Number=0, Y:Number=0){
			super(X, Y, null);
			makeGraphics();
			play(ANIM_FLASH);			
		}
		
		public function imidiateRespawn():void{
			respawnTime = true;
		}
		
		public function startRespawnTimer():void{
			if(respawnTimer == null){
				respawnTimer = new Timer(FlxMath.rand(3000, 6000), 1);
				respawnTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onRespawnTime);
				respawnTimer.start();
			}
		}
		
		private function onRespawnTime(e:TimerEvent):void{
			respawnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onRespawnTime);
			respawnTimer.stop();
			respawnTimer = null;
			respawnTime = true;
		}
		
		private function makeGraphics():void{
			makeGraphic(50, 50, 0xFFFFFFFF);
			loadGraphic(BIRTH_PLACE, true, false, 11, 11, true);
			addAnimation(ANIM_FLASH, [0, 1], 5, true);
			addAnimation(ANIM_STOP, [0], 0, false);
		}
		
		override public function update():void{
			super.update();
			if(full){
				play(ANIM_STOP);
			}else{
				play(ANIM_FLASH);
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