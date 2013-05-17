package  {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Background {
		private static const CloudSpeed:Number = 0.05;
		private static const CloudSpeed2:Number = 0.025;
		
		private var bgcloud:BgCloud1;
		private var bgcloud2:BgCloud1 = null;
		private var landscape:Landscape1;
		private var landscapeHeight:uint;
		private var climbTarget:uint;
		
		private var cloudTimer:Timer;
		private var rgo:RainbowGameObject;
		
		public function Background(rgo:RainbowGameObject, target) {
			this.rgo = rgo;
			this.climbTarget = target;
			
			this.landscape = new Landscape1();
			this.landscapeHeight = 768;
			this.landscape.setX(0);
			this.landscape.setY(-RainbowGameObject.StageHeight / 2);
			this.rgo.addChild(this.landscape);
			this.rgo.setChildIndex(this.landscape, 0);
			
			this.bgcloud = new BgCloud1();
			this.bgcloud.setX(-RainbowGameObject.StageWidth / 2 - 500);
			this.bgcloud.setY(this.getNextY(false));
			this.rgo.addChild(this.bgcloud);
			
			this.cloudTimer = new Timer(5000, 1);
			this.cloudTimer.addEventListener(TimerEvent.TIMER_COMPLETE, addCloud);
			this.cloudTimer.start();
		}
		
		private function addCloud(event:TimerEvent) {
			this.bgcloud2 = new BgCloud1();
			this.bgcloud2.setX(-RainbowGameObject.StageWidth / 2 - 500);
			this.bgcloud2.setY(this.getNextY(true));
			this.rgo.addChild(this.bgcloud2);
			
			// move sea of fire and hero to front
			if (this.rgo.hero != null) {
				this.rgo.setChildIndex(MovieClip(rgo.seaOfFire), rgo.numChildren-1);
				this.rgo.setChildIndex(MovieClip(rgo.hero), rgo.numChildren-1);
			}
			
			this.cloudTimer.stop();
		}
		
		// scroll landscape and move big clouds
		// @param currentDist is the current climb distance
		public function play(timeDiff:int, currentDist:Number) {
			// move landscape
			var maxDy = this.landscapeHeight - RainbowGameObject.StageHeight;
			var currentDy = maxDy * (currentDist / 10 / this.climbTarget);
			this.landscape.setY(-RainbowGameObject.StageHeight / 2 -currentDy);
			
			// move big cloud
			if (this.bgcloud.mx > RainbowGameObject.StageWidth / 2 + 300) {
				this.bgcloud.setX(-RainbowGameObject.StageWidth / 2 - 300);
				if (this.bgcloud2 == null || this.bgcloud2.my > 0) {
					this.bgcloud.setY(this.getNextY(false));
				} else {
					this.bgcloud.setY(this.getNextY(true));
				}
			}
			this.bgcloud.setX(this.bgcloud.mx + timeDiff * CloudSpeed);
			
			// move second big cloud
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
		
		// get the next y position for a big cloud
		private function getNextY(isUpper:Boolean):Number {
			if (isUpper) {
				return (Math.random() * (RainbowGameObject.StageHeight - 200) / 2);
			} else {
				return -(Math.random() * (RainbowGameObject.StageHeight - 200) / 2);
			}
		}
	}
}
