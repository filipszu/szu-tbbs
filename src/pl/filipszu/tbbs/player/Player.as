package pl.filipszu.tbbs.player {
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	import org.flixel.plugin.photonstorm.FlxMath;
	
	import pl.filipszu.tbbs.model.GameModel;
	import pl.filipszu.tbbs.worm.WormBirthPlace;
	import pl.filipszu.tbbs.worm.Worm_proto;
	
	public class Player extends FlxSprite{
		
		public static const WIDTH:Number = 21;
		public static const HEIGHT:Number = 21;
		
		public const ANIM_IDLE:String = 'idle';
		public const ANIM_FLY:String = 'fly';
		
		public var worm:Worm_proto;
		
		[Embed(source="../../../../assets/PLAYER.png")] private var PLAYER:Class;
		private var model:GameModel = GameModel.getInstance();
		private var _full:Boolean = false;
		private var _lastSpeed:FlxPoint;
		
		public function Player(xPos:Number, yPos:Number) {
			super(xPos, yPos, null);
			model.player = this;
			makeGraphics();
			play(ANIM_IDLE);
			addControls();
			lastSpeed = new FlxPoint(0,0);
		}
		
		public function get lastSpeed():FlxPoint{
			return _lastSpeed;
		}

		public function set lastSpeed(value:FlxPoint):void{
			_lastSpeed = value;
		}

		public function get full():Boolean{
			return _full;
		}

		public function set full(value:Boolean):void{
			if(_full != value){
				_full = value;
			}
		}

		private function makeGraphics():void{
			loadGraphic(PLAYER, true, false, 31, 26, true);
			addAnimation(ANIM_IDLE, [0], 10, false);
			addAnimation(ANIM_FLY, [0, 1, 2, 3, 4, 5], 20, false);
			this.width = 21;
			this.height = 21;
			this.offset = new FlxPoint(5, 5);
		}
		
		private function addControls():void{
			if(FlxG.getPlugin(FlxControl) == null){
				FlxG.addPlugin(new FlxControl);
			}
			
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES,  1, true, false);
			FlxControl.player1.setCursorControl(true, false, true, true);
			FlxControl.player1.setMovementSpeed(200, 300, 200, 200, 50, 50);
			FlxControl.player1.setGravity(0, 250);
			
		}
		
		override public function update():void{
			super.update();
			
			if(FlxG.keys.UP){
				play(ANIM_FLY);
			}
			
			lastSpeed.x = velocity.x, 
			lastSpeed.y = velocity.y;
			
		}

	}
	
}
