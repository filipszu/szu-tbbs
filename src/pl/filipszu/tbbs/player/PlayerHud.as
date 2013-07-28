package pl.filipszu.tbbs.player {
	import org.flixel.FlxSprite;
	import pl.filipszu.tbbs.model.GameModel;
	import org.flixel.FlxGroup;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	public class PlayerHud extends FlxGroup{
		
		[Embed(source="../../../../assets/arrow.png")] private var ARROW:Class;
		private var model:GameModel = GameModel.getInstance();
		private var bg:FlxSprite;
		private var mapCamera:FlxCamera;
		private var pointsLabel:FlxText;
		private var fullLabel:FlxText; 
		private var mouseLabel:FlxText;
		public const HEIGHT:Number = 20;
		private var bar:FlxSprite;
		//private const MINI_MAP_SCALE:Number = HEIGHT * 1.5 / model.viewBounds.height;
		private var pointer:FlxSprite;
		
		public function PlayerHud(){
			super();
			createBG();
			createLabels();
			createPointer();
			addHealthBar();
			//createMiniMap();
		}
		
		private function addHealthBar():void{
			var frame:FlxSprite = new FlxSprite(170, model.viewBounds.height - HEIGHT+5);
			frame.makeGraphic(50,10); //White frame for the health bar
			frame.scrollFactor.x = frame.scrollFactor.y = 0;
			add(frame);
 
			var inside:FlxSprite = new FlxSprite(171, model.viewBounds.height - HEIGHT+6);
			inside.makeGraphic(48,8,0xff000000); //Black interior, 48 pixels wide
			inside.scrollFactor.x = inside.scrollFactor.y = 0;
			add(inside);
 
			bar = new FlxSprite(171, model.viewBounds.height - HEIGHT+6);
			bar.makeGraphic(1,8,0xffff0000); //The red bar itself
			bar.scrollFactor.x = bar.scrollFactor.y = 0;
			bar.origin.x = bar.origin.y = 0; //Zero out the origin
			bar.scale.x = 48; //Fill up the health bar all the way
			add(bar);
		}
		
		private function createLabels():void{
			pointsLabel = new FlxText(10, model.viewBounds.height - HEIGHT + 3, 100, 'TEST');
			pointsLabel.scrollFactor.x = pointsLabel.scrollFactor.y = 0;
			pointsLabel.setFormat(null, 8, 0xFFFFFF,'left');
			add(pointsLabel);
			
			fullLabel = new FlxText(model.viewBounds.width - 160, model.viewBounds.height - HEIGHT + 3, 150, 'TEST');
			fullLabel.setFormat(null, 8, 0xFFFFFF,'right');
			fullLabel.scrollFactor.x = fullLabel.scrollFactor.y = 0;
			add(fullLabel);
			
			mouseLabel = new FlxText(70, model.viewBounds.height - HEIGHT, 100, 'MOUSE');
			mouseLabel.scrollFactor.x = mouseLabel.scrollFactor.y = 0;
			//add(mouseLabel);
			
		}
		
		private function createPointer():void{
			pointer = new FlxSprite(0 ,0, ARROW);
			pointer.antialiasing = true;
			//pointer.scrollFactor.x = pointer.scrollFactor.y = 0;
			add(pointer);
		}
		/*
		private function createMiniMap():void{
			mapCamera = new FlxCamera(model.levelBounds.width - model.levelBounds.width * MINI_MAP_SCALE, model.levelBounds.height - model.levelBounds.height * MINI_MAP_SCALE, model.levelBounds.width, model.levelBounds.height, MINI_MAP_SCALE);
			mapCamera.setBounds(0, 0, model.levelBounds.width, model.levelBounds.height, false);
			
			//mapCamera.color = 0xFFCC0000;
			//mapCamera.follow(model.player);
			FlxG.addCamera(mapCamera);
		}
		*/
		private function createBG():void{
			bg = new FlxSprite(0, model.viewBounds.height - HEIGHT, null);
			bg.makeGraphic(model.viewBounds.width, HEIGHT, 0xFF66CC66);
			bg.scrollFactor.x = bg.scrollFactor.y = 0;
			bg.y = model.viewBounds.height - HEIGHT;
			add(bg);
		}
		
		override public function update():void{
			super.update();
			
			mouseLabel.text = 'MOUSE: '+Math.floor(FlxG.mouse.x)+', '+Math.floor(FlxG.mouse.y);
			pointsLabel.text = 'POINTS: '+model.currentPoints+'/'+model.level.MAX_WORMS_CATCH;
			
			bar.scale.x = 48 * model.player.health;
			//fullLabel.text = 'Time: '+Math.floor(model.time).toString();
			var hrTime:String = 'Time: '+convertToHHMMSS(Math.floor(model.time));
			fullLabel.text = hrTime;
			if(model.player.full){
				
				pointer.visible = true;
				//pointer.scrollFactor.x = pointer.scrollFactor.y = 0;
				
				
				var dx:int = model.level.nestPoint.x - model.player.x + .5 * model.player.width - pointer.width * .5;
            	var dy:int = model.level.nestPoint.y - model.player.y + .5 * model.player.height - pointer.height * .5;
            
            	var cursorAngle:Number = Math.atan2(dy, dx);
				var cursorDegree:Number = 360*(cursorAngle/(2*Math.PI));
				var dist:Number = Math.sqrt(dx*dx+dy*dy);
				
				pointer.angle = cursorDegree;
				
				pointer.x = (model.player.x + .5 * model.player.width - pointer.width * .5) + model.player.width  * Math.cos(cursorAngle);
				pointer.y = (model.player.y + .5 * model.player.height - pointer.height * .5) + model.player.width  * Math.sin(cursorAngle) ;
				
			}else{
				//fullLabel.text = 'EMPTY';
				pointer.visible = false;
			}
		}
		
		private function convertToHHMMSS($seconds:Number):String{
			var s:Number = $seconds % 60;
			var m:Number = Math.floor(($seconds % 3600 ) / 60);
			var h:Number = Math.floor($seconds / (60 * 60));
			 
			var hourStr:String = (h == 0) ? "" : doubleDigitFormat(h) + ":";
			var minuteStr:String = doubleDigitFormat(m) + ":";
			var secondsStr:String = doubleDigitFormat(s);
			 
			return hourStr + minuteStr + secondsStr;
		}
		
		private function doubleDigitFormat($num:uint):String{
			if ($num < 10) 
			{
				return ("0" + $num);
			}
			return String($num);
		}
	}
	
}
