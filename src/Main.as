package{
	import flash.display.Sprite;
	
	import pl.filipszu.tbbs.Game;
	[SWF(width="800", height="400", frameRate="60")]
	public class Main extends Sprite{
		
		public function Main(){
			var game:Game = new Game(400, 200);
			addChild(game);
		}
	}
}