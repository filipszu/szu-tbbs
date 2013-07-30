package{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import org.flixel.FlxG;
	
	import pl.filipszu.tbbs.AssetsLib;
	import pl.filipszu.tbbs.Game;
	import pl.filipszu.tbbs.screens.StartScreen;
	import pl.filipszu.tbbs.states.MenuState;
	import pl.filipszu.tbbs.states.PlayState;

	[SWF(width="800", height="400", frameRate="60", backgroundColor="#65CCF5")]
	public class Main extends MovieClip{
		
		private var game:Game;
		private var wrapper:MovieClip;
		
		public function Main(){
			addEventListener(Event.ADDED_TO_STAGE, whenOnStage);
		}
		
		private function whenOnStage(e:Event):void{
			stage.removeEventListener(Event.ADDED_TO_STAGE, whenOnStage);
			play();
			stage.stageFocusRect = false;
			game = new Game(400, 200);
			addChild(game);
			Mouse.show();
			createWrapper();
			showStartScreen();
			stage.addEventListener('game over', onGameOver);
			stage.addEventListener('congrats', onCongrats);
		}
		
		protected function onCongrats(e:Event):void{
			FlxG.resetGame();
			clearWrapper();
			
			var congrats:CangratsScreenMC = new CangratsScreenMC();
			congrats.name = 'screen';
			congrats.x = 20;
			congrats.y = 20;
			congrats.addEventListener(MouseEvent.CLICK, onReStartClick);
			wrapper.addChild(congrats);
			addChild(wrapper);
			
		}
		
		private function createWrapper():void{
			wrapper = new MovieClip();
			wrapper.name = 'wrapper';
			
			addChild(wrapper);
		}
		
		private function onStartClick(e:MouseEvent):void{
			startGame();
		}
		
		private function onReStartClick(e:MouseEvent):void{
			startGame();
		}
		
		private function startGame():void{
			//FlxG.switchState(new PlayState());
			removeChild(wrapper);
			Mouse.show();
			FlxG.stage.focus = game;
			FlxG.paused = false;
			//FlxG.resetState();
		}
		
		private function showStartScreen():void{
			clearWrapper();
			FlxG.paused = true;
			var startScreen:StartScreen = new StartScreen();
			startScreen.name = 'screen';
			startScreen.x = 20;
			startScreen.y = 20;
			startScreen.addEventListener(MouseEvent.CLICK, onStartClick);
			wrapper.addChild(startScreen);			
			
			
		}
		
		private function onGameOver(e:Event):void{
			FlxG.resetGame();
			clearWrapper();
		
			var gameOverScreen:GameOverScreenMC = new GameOverScreenMC();
			gameOverScreen.name = 'screen';
			gameOverScreen.x = 20;
			gameOverScreen.y = 20;
			gameOverScreen.addEventListener(MouseEvent.CLICK, onReStartClick);
			wrapper.addChild(gameOverScreen);
			addChild(wrapper);
		}
		
		private function clearWrapper():void{
			while (wrapper.numChildren > 0) {
				wrapper.removeChildAt(0);
			}
		}
	}
}