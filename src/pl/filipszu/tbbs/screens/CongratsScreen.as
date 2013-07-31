package pl.filipszu.tbbs.screens{
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import pl.filipszu.tbbs.model.GameModel;
	
	public class CongratsScreen extends CongratsScreenMC{
		
		private var model:GameModel = GameModel.getInstance();
		
		public function CongratsScreen(){
			super();
			init();
		}
		
		private function init():void{
			time.text = model.timeString();
			
			congratsMsg.rotation = -5;
			var tl:TimelineMax = new TimelineMax();
			tl.append(new TweenLite(congratsMsg, 0.3, {alpha: 1, ease: Linear.easeNone}));
			tl.append(new TweenLite(congratsMsg, 1, {scaleX: 1.2, scaleY: 1.2, ease:Elastic.easeInOut, rotation: 5}));
			tl.append(new TweenLite(congratsMsg, 0.3, {alpha: 0, ease: Linear.easeNone}));
			tl.append(new TweenLite(congratsMsg, 0.3, {alpha: 1, ease: Linear.easeNone}));
			tl.append(new TweenLite(congratsMsg, 1, {scaleX: 1, scaleY: 1, ease:Elastic.easeInOut, rotation: -5}));
			tl.append(new TweenLite(congratsMsg, 0.3, {alpha: 0, ease: Linear.easeNone}));
			tl.repeat(-1);
			tl.play();
		}
		
	}
	
}