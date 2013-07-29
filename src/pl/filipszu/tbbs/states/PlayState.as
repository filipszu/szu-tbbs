package pl.filipszu.tbbs.states{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxDisplay;
	import org.flixel.plugin.photonstorm.FlxMath;
	
	import pl.filipszu.tbbs.enemies.Mine;
	import pl.filipszu.tbbs.enemies.Mine_proto;
	import pl.filipszu.tbbs.maps.Level_Level5;
	import pl.filipszu.tbbs.maps.Level_proto;
	import pl.filipszu.tbbs.model.GameModel;
	import pl.filipszu.tbbs.player.Nest_proto;
	import pl.filipszu.tbbs.player.Player;
	import pl.filipszu.tbbs.player.PlayerHud;
	import pl.filipszu.tbbs.popUp.PopUp;
	import pl.filipszu.tbbs.worm.WormBirthPlace;
	import pl.filipszu.tbbs.worm.WormTeleport;
	import pl.filipszu.tbbs.worm.Worm_proto;
	
	public class PlayState extends FlxState{
		
		[Embed(source="../../../../assets/bg.png")] private var BG:Class;
		private var time:Number = 0;
		private var model:GameModel = GameModel.getInstance();
		private var level:Level_proto;
		private var nest:Nest_proto;
		private var player:Player;
		private var hud:PlayerHud;
		private var birthPlaces:FlxGroup;
		private var worms:FlxGroup;
		private var bounds:FlxGroup;
		private var mines:FlxGroup;
		private var minesSpots:FlxGroup;
		private var mineEx:FlxGroup;
		
		//private var teleports:FlxGroup;
		private var respawnTimer:FlxDelay;
		
		public function PlayState(_levelData:Level_proto = null) {
			if(_levelData == null){
				level = new Level_Level5();
			}else{
				level = _levelData;
			}
			
		}
		
		override public function create():void{
			resetModel();
			//FlxG.mouse.show();
			
			trace(FlxG.stage.focus);
			add(new FlxSprite(0, 0, BG));
			addLevel();
			addWorms();
			addMines();
			addPlayer();
			addNest();
			setCamera();
		}
		
		private function resetModel():void{
			model.currentPoints = 0;
			model.time = 0;
			if(model.player != null){
				model.player.full = false;
				if(model.player.worm != null){
					model.player.worm = null;
				}
			}
			
			
		}
		
		private function addMines():void{
			mines = new FlxGroup();
			minesSpots = new FlxGroup();
			mineEx = new FlxGroup();
			var minePoints:Array = [new Point(110, 160), new Point(170, 160), 
									new Point(203, 80), new Point(56, 240), 
									new Point(202, 288), new Point(202, 368), 
									new Point(252, 368), new Point(332, 368), 
									new Point(295, 192), new Point(397, 64),
									new Point(441, 32), new Point(467, 128),
									new Point(559, 32), new Point(575, 80),
									new Point(634, 80),  
									new Point(452, 256), new Point(605, 144),
									new Point(567, 240),  new Point(550, 320),
									new Point(623, 240), new Point(705, 368),
									new Point(500, 368), 
									new Point(765, 368)];
			
			for(var i:uint = 0; i< minePoints.length; i++){
				
				var point:Point = minePoints[i] as Point;
				var mine:Mine_proto = new Mine_proto(point.x, point.y);
				mine.id = i;
				mines.add(mine);
				minesSpots.add(mine.hotSpot);
				mineEx.add(mine.explosion);
			}
			
			add(mines);
		}
		
		private function addWorms():void{
			worms = new FlxGroup();
			birthPlaces = new FlxGroup();
			
			for each(var point:FlxPoint in level.birthPlaces){
				
				var worm:Worm_proto = new Worm_proto(point.x + Worm_proto.WIDTH/2, point.y - Worm_proto.HEIGHT);
				worms.add(worm);
				worm.visible = true;
				
				if(FlxMath.chanceRoll()){
					worm.velocity.x = model.WORM_SPEED;
				}else{
					worm.velocity.x = -model.WORM_SPEED;
				}
				
			}
			
			add(worms);
			
		}
		
		private function setCamera():void{
			FlxG.camera.setBounds(0, 0, level.boundsMaxX, level.boundsMaxY + hud.HEIGHT, true);
			FlxG.camera.follow(player);
		}
		
		private function addPlayer():void{
			player = new Player(level.nestPoint.x, level.nestPoint.y - Player.HEIGHT);
			add(player);
			hud = new PlayerHud();
			add(hud);
		}
		
		private function addNest():void{
			nest = new Nest_proto(level.nestPoint.x, level.nestPoint.y);
			add(nest);
		}
		
		private function addLevel():void{
			add(level.mainLayer);
			model.level = level;
			setLevelBounds();
		}
		
		private function setLevelBounds():void{
			bounds = new FlxGroup();
			var left:FlxTileblock = new FlxTileblock(0, 0, 1, level.boundsMaxY);
			bounds.add(left);
			var top:FlxTileblock = new FlxTileblock(0, 0, level.boundsMaxX, 1);
			bounds.add(top);
			var right:FlxTileblock = new FlxTileblock(level.boundsMaxX-1, 0, 1, level.boundsMaxY);
			bounds.add(right);
			var bottom:FlxTileblock = new FlxTileblock(0, level.boundsMaxY-1, level.boundsMaxX, 1);
			bounds.add(bottom);
			add(bounds);
			FlxG.worldBounds = new FlxRect(level.boundsMinX, level.boundsMinY, level.boundsMaxX, level.boundsMaxY);
		}
		
		override public function update():void{
			super.update();
			FlxG.collide(player, bounds);
			FlxG.collide(player, level.mainLayer, onPlayerCollide);
			FlxG.collide(worms, level.mainLayer, onWormCollide);
			FlxG.collide(worms, bounds, onWormCollide);
			FlxG.overlap(player, nest, onNestOverlap);
			FlxG.overlap(player, worms, onWormOverlap);
			FlxG.overlap(player, minesSpots, onMineOverlap); 
			//FlxG.overlap(player, mineEx, onExplosionOverlap);
			for(var i:uint = 0; i < mines.length; i++){
				var mine:Mine_proto = mines.members[i] as Mine_proto;
				if(FlxCollision.pixelPerfectCheck(player, mine.explosion)){
					onExplosionOverlap(mine);
				}
			}
			
			updateMines();
			
			if(player.health <= 0){
				advance();
			}
			
			model.time += FlxG.elapsed;
			if(FlxG.keys.SPACE){
				mines.kill();
				minesSpots.kill();
				addMines();
			}
		}
		
		private function onExplosionOverlap(mine:Mine_proto):void{
			var explosion:FlxSprite = mine.explosion;
			if(explosion.frame != 0){
				shakeScreen(false) ;
				player.health -= .015;
			}
		}
		
		private function updateMines():void{
			for(var i:uint = 0; i < mines.length; i++){
				var mine:Mine_proto = mines.members[i] as Mine_proto;
				if(!mine.alive){
					mines.remove(mine, true);
					minesSpots.remove(mine.hotSpot, true);
					mineEx.remove(mine.explosion, true);
				}
			}
		}
		
		private function onMineOverlap(player:Player, mine_space:FlxSprite):void{
			var mine:Mine_proto = get_mine(mine_space);
			//trace(mine.id);
			if(mine.ready){
				mine.triger();
			}
		}
		
		private function get_mine(space:FlxSprite):Mine_proto{
			for(var i:uint = 0; i < mines.length; i++){
				var mine:Mine_proto = mines.members[i] as Mine_proto;
				if(mine.itSpace(space) || mine.itEx(space)){
					return mine;
				}
			}
			return null;
		}
		
		private function onWormCollide(obj1:FlxObject, obj2:FlxObject):void
		{
			if(obj1.isTouching(FlxObject.LEFT)){
				obj1.velocity.x = 10;
			}
			if(obj1.isTouching(FlxObject.RIGHT)){
				obj1.velocity.x = -10;
			}
		}
		
		private function onPlayerCollide(obj1:FlxObject, obj2:FlxObject):void{
			if(player.isTouching(FlxObject.LEFT)){
				if(player.lastSpeed.x < -model.maxLandingSpeed){
					FlxG.log('too fast LEFT hit!');
					shakeScreen(false);
					player.health -= .35;
				}
			}
			
			if(player.isTouching(FlxObject.RIGHT)){
				if(player.lastSpeed.x > model.maxLandingSpeed){
					FlxG.log('too fast RIGHT hit!');
					shakeScreen(false);
					player.health -= .35;
				}
			}
			
			if(player.isTouching(FlxObject.FLOOR)){
				if(player.lastSpeed.y > model.maxLandingSpeed){
					FlxG.log('too fast DOWN hit!');
					shakeScreen(true);
					player.health -= .35;
				}
			}
			
			if(player.isTouching(FlxObject.CEILING)){
				if(player.lastSpeed.y < -model.maxLandingSpeed){
					FlxG.log('too fast UP hit!');
					shakeScreen(true);
					player.health -= .35;
				}
			}	
		}
		
		private function shakeScreen(vertical:Boolean = true):void{
			var camera:FlxCamera = FlxG.cameras[0] as FlxCamera;
			if(vertical){
				camera.shake(0.02, 0.2, null, true, FlxCamera.SHAKE_VERTICAL_ONLY);
			}else{
				camera.shake(0.02, 0.2, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
			}
			
		}
		
		private function onWormOverlap(player:Player, worm:Worm_proto):void{
			if(worm.visible && !player.full){
				worm.visible = false;
				player.worm = worm;
				player.full = true;
				teleportWorm(worm.x + worm.width/2, worm.y + worm.height/2, true);
			}
		}
		
		private function teleportWorm(xPos:Number, yPos:Number, out:Boolean = false):void{
			var teleport:WormTeleport = new WormTeleport(xPos, yPos);
			add(teleport);
			if(out){
				teleport.play(teleport.ANIM_TELEPORT_OUT);
			}else{
				teleport.play(teleport.ANIM_TELEPORT_IN);
			}
		}
		
		private function onNestOverlap(_player:Player, _nest:Nest_proto):void{
			if(player.full){
				nest.play(nest.OPEN);
				player.full = false;
				player.worm = null;
				
				model.currentPoints++;
				if(model.currentPoints == model.level.MAX_WORMS_CATCH){
					advance();
				}
			}
		}
		
		private function returnToMenu():void{
			FlxG.switchState(new MenuState());
		}
		
		private function restartLevel():void{
			var levelClass:Class = getDefinitionByName('source.maps::Level'+model.currentLevelIndex) as Class;
			var level = new levelClass();
		}
		
		private function restart():void{
			FlxG.camera.flash(0xFF66CC66, 2, afterRestartFlash, true);
		}
		
		private function afterRestartFlash():void{
			restartLevel();	
		}
		
		private function advance():void{
			//FlxG.camera.fade(0xFF66CC66, 3, afterAdvanceFlash, true);
			returnToMenu();
		}
		
		private function afterAdvanceFlash():void{
			returnToMenu();
		}
		
	}
	
}
