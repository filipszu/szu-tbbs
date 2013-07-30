package pl.filipszu.tbbs.screens{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	public class StartScreen extends StartScreenMC{
		
		public function StartScreen(){
			super();
			init();
		}
	
		private function init():void{
			startMsg.rotation = -5;
			var tl:TimelineMax = new TimelineMax();
			tl.append(new TweenLite(startMsg, 0.3, {alpha: 1, ease: Linear.easeNone}));
			tl.append(new TweenLite(startMsg, 1, {scaleX: 1.2, scaleY: 1.2, ease:Elastic.easeInOut, rotation: 5}));
			tl.append(new TweenLite(startMsg, 0.3, {alpha: 0, ease: Linear.easeNone}));
			tl.append(new TweenLite(startMsg, 0.3, {alpha: 1, ease: Linear.easeNone}));
			tl.append(new TweenLite(startMsg, 1, {scaleX: 1, scaleY: 1, ease:Elastic.easeInOut, rotation: -5}));
			tl.append(new TweenLite(startMsg, 0.3, {alpha: 0, ease: Linear.easeNone}));
			tl.repeat(-1);
			tl.play();
		}
		
		
	}
	
}