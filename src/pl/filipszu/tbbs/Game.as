package pl.filipszu.tbbs{
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	import pl.filipszu.tbbs.states.MenuState;
	import pl.filipszu.tbbs.states.PlayState;
	
	/**
	 * ...
	 * @author FilipSZU
	 */
	public class Game extends FlxGame{
		
		public function Game(gameWidth:Number, gameHeight:Number){
			super(gameWidth, gameHeight, MenuState, 2);
			this.forceDebugger = true;
			useSystemCursor = true;
			//FlxG.visualDebug = true;
		}
		
	}

}