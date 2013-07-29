package{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.flixel.FlxG;
	
	import pl.filipszu.tbbs.AssetsLib;
	import pl.filipszu.tbbs.Game;

	[SWF(width="800", height="400", frameRate="60")]
	public class Main extends Sprite{
		
		private var game:Game;
		private var wrapper:MovieClip;
		
		public function Main(){
			stage.stageFocusRect = false;
			game = new Game(400, 200);
			addChild(game);
			createWrapper();
			showStartScreen();
		}
		
		private function createWrapper():void{
			wrapper = new MovieClip();
			wrapper.name = 'wrapper';
			
			var bg:Bitmap = new AssetsLib.BG();
			wrapper.addChild(bg);
			
			addChild(wrapper);
		}
		
		private function onStartClick(e:MouseEvent):void{
			startGame();
		}
		
		private function startGame():void{
			
			removeChild(getChildByName('wrapper'));
			FlxG.stage.focus = game;
		}
		
		private function showStartScreen():void{
			var startScreen:StartScreen = new StartScreen();
			startScreen.name = 'screen';
			startScreen.x = 20;
			startScreen.y = 20;
			startScreen.addEventListener(MouseEvent.CLICK, onStartClick);
			wrapper.addChild(startScreen);			
		}
	}
}