package  {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Background {
		
		private static const CloudSpeed:Number = 0.05;
		private static const CloudSpeed2:Number = 0.025;
		
		private var bgcloud:BgCloud1;
		private var bgcloud2:BgCloud1 = null;
		
		private var rgo:RainbowGameObject;
		
		public function Background(rgo:RainbowGameObject) {
			this.rgo = rgo;
			
			this.bgcloud = new BgCloud1();
			this.bgcloud.setX(-RainbowGameObject.StageWidth / 2 - 500);
			this.bgcloud.setY(this.getNextY(false));
			this.rgo.addChild(this.bgcloud);
			
			var cloudTimer:Timer = new Timer(5000, 1);
			cloudTimer.addEventListener(TimerEvent.TIMER_COMPLETE, addCloud);
			cloudTimer.start();
		}
		
		private function addCloud(event:TimerEvent) {
			this.bgcloud2 = new BgCloud1();
			this.bgcloud2.setX(-RainbowGameObject.StageWidth / 2 - 500);
			this.bgcloud2.setY(this.getNextY(true));
			this.rgo.addChild(this.bgcloud2);
		}
		
		public function play(timeDiff:int) {
			if (this.bgcloud.mx > RainbowGameObject.StageWidth / 2 + 300) {
				this.bgcloud.setX(-RainbowGameObject.StageWidth / 2 - 300);
				if (this.bgcloud2 == null || this.bgcloud2.my > 0) {
					this.bgcloud.setY(this.getNextY(false));
				} else {
					this.bgcloud.setY(this.getNextY(true));
				}
			}
			this.bgcloud.setX(this.bgcloud.mx + timeDiff * CloudSpeed);
			
			if (this.bgcloud2 != null) {
				if (this.bgcloud2.mx > RainbowGameObject.StageWidth / 2 + 300) {
					this.bgcloud2.setX(-RainbowGameObject.StageWidth / 2 - 300);
					if (this.bgcloud.my > 0) {
						this.bgcloud2.setY(this.getNextY(false));
					} else {
						this.bgcloud2.setY(this.getNextY(true));
					}
				}
				this.bgcloud2.setX(this.bgcloud2.mx + timeDiff * CloudSpeed2);
			}
		}
		
		private function getNextY(isUpper:Boolean):Number {
			if (isUpper) {
				return (Math.random() * (RainbowGameObject.StageHeight - 200) / 2);
			} else {
				return -(Math.random() * (RainbowGameObject.StageHeight - 200) / 2);
			}
		}
	}
}
