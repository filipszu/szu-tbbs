package pl.filipszu.tbbs.popUp{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class PopUp extends FlxSprite{
		public function PopUp(){
			super(FlxG.camera.width/2 - 100, FlxG.camera.height/2-50, null);
			makeGraphic(200, 100, 0xFF66CC66);
			scrollFactor.x = scrollFactor.y = 0;
		}
	}
}