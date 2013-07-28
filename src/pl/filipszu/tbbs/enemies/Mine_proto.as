package pl.filipszu.tbbs.enemies{
	import pl.filipszu.tbbs.enemies.Mine;
	import org.flixel.FlxSprite;
	import pl.filipszu.tbbs.model.GameModel;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTimer;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	public class Mine_proto extends FlxGroup{
		
		public var X:Number;
		public var Y:Number;
		public var id:uint = 0;
		
		[Embed(source="../../../../assets/ex_850.png")] private var EX:Class;
		
		public var ready:Boolean = true;
		private var trigered:Boolean = false;
		private var model:GameModel = GameModel.getInstance();
		private var mine:Mine;
		public var explosion:FlxSprite;
		public var hotSpot:FlxSprite;
		private var exTimer:FlxDelay = new FlxDelay(1500);
		
		public function Mine_proto(_X:Number, _Y:Number) {
			super();
			X = _X;
			Y = _Y - 30;
			createGraphics();
		}
		
		public function triger():void{
			if(!trigered){
				trigered = true;
				startFlashing();
				exTimer.start();
			}
		}
		
		private function afterExTime():void{
			explosion.play('bum');
			exTimer.abort();
			ready = false;
			mine.visible = false;
		}
		
		private function startFlashing():void{
			
			mine.play(mine.ANIM_FLASH);
		}
		
		private function createGraphics():void{
			
			hotSpot = new FlxSprite(X, Y, null);
			hotSpot.makeGraphic(30, 30, 0x00CC0000);
			add(hotSpot);
			mine = new Mine(X + 15 - Mine.WIDTH/2, Y + 30 - Mine.HEIGHT);
			add(mine);
			
			explosion = new FlxSprite(X + 15 - 50, Y + 30 - 49, null);
			explosion.loadGraphic(EX, true, false, 85, 79, true);
			explosion.addAnimation('bum', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0], 15, false);
			explosion.addAnimation('stop', [0], 0, false);
			explosion.play('stop');
			add(explosion);
		}
		
		public function itSpace(space:FlxSprite):Boolean{
			if(space == hotSpot){
				return true;
			}
			return false;
		}
		
		public function itEx(ex:FlxSprite):Boolean{
			if(ex == explosion){
				return true;
			}
			return false;
		}
		
		override public function update():void{
			super.update();
			
			if(explosion.finished && !ready && exTimer.hasExpired){
				this.kill();
				this.mine.kill();
				this.hotSpot.kill();
			}
			
			if(exTimer.hasExpired && ready){
				afterExTime();
			}
		}
	}
	
}
