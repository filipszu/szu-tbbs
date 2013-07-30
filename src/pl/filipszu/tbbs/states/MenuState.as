package pl.filipszu.tbbs.states{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	
	import pl.filipszu.tbbs.maps.Level_Level5;
	import pl.filipszu.tbbs.maps.Level_proto;
	import pl.filipszu.tbbs.model.GameModel;
	
	/**
	 * ...
	 * @author FilipSZU
	 */
	public class MenuState extends FlxState{
		
		[Embed(source="../../../../assets/bg.png")] private var BG:Class;
		[Embed(source="../../../../assets/GROBOLD.ttf", fontFamily="GRO", embedAsCFF="false")] 	public	var	FontGRO:String;
		
		public var menuText:FlxText;
		private var textString; 
		private var model:GameModel = GameModel.getInstance();
		private var bg:FlxSprite;
		
		public function MenuState(){
			//FlxG.switchState(new PlayState(new Level1(false)));
		}
		
		override public function create():void{
			bg = new FlxSprite(0, 0, BG) 
			add(bg);
			model.currentLevelIndex = 0;
			
			/*
			var s:FlxText = new FlxText(FlxG.width/2 - 155, 10, 310, 'This is a TEST game. Catch worms bring them to the big bird.', true);
			s.setFormat("GRO", 18, 0x000000, 'left');
			s.antialiasing = true;
			add(s);
			
			var s3:FlxText = new FlxText(FlxG.width/2 - 125, 70, 250, 'PRESS ANY KEY TO START', true);
			s3.setFormat("GRO", 18, 0xCC0000, 'left');
			s3.antialiasing = true;
			add(s3);
			
			var s1:FlxText = new FlxText(FlxG.width/2 - 42, 150, 84, 'use arrow keys:');
			s1.setFormat("GRO", 9, 0x000000, 'center');
			add(s1);
			var s2:FlxText = new FlxText(FlxG.width/2 - 50, 170, 100, '[UP] [LEFT] [RIGHT]');
			s2.setFormat("GRO", 8, 0xCC0000, 'center');
			add(s2);
			*/	
		}
		
		private function onStageClick(e:MouseEvent):void{
			
		}
		
		override public function update():void{
			super.update();
			if(FlxG.keys.any()){
				var level = new Level_Level5();
				FlxG.switchState(new PlayState(level));
			}
		}
		
	}

}