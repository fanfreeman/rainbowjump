package  {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public dynamic class Hero extends MovieClip {
		public var mx:int;
		public var my:int;
		
		private var rgo:RainbowGameObject;
		private var abilityTimer:Timer;
		private var abilityReady:Boolean = true;

		public function Hero(rgo:RainbowGameObject) {
			this.mx = 0;
			this.my = 0;
			this.rgo = rgo;
		}

		public function setX(newX:int) {
			// enable left and right border warp
			if (newX < -1 * RainbowGameObject.StageWidth / 2) {
				newX += RainbowGameObject.StageWidth;
			}
			else if (newX >= RainbowGameObject.StageWidth / 2) {
				newX -= RainbowGameObject.StageWidth;
			}
			
			this.mx = newX;
			this.x = RainbowGameObject.StageWidth / 2 + newX;
		}
		
		public function setY(newY:int) {
			this.my = newY;
			this.y = RainbowGameObject.StageHeight / 2 - newY;
		}
		
		public function triggerSpecialAbility() {
			if (this.abilityReady) {
				// activate ability
				this.rgo.dy = 1.5;
				rgo.soundControl.playBoom();
				
				this.abilityReady = false;
				this.abilityTimer = new Timer(5000, 1);
				this.abilityTimer.addEventListener(TimerEvent.TIMER_COMPLETE, setAbilityReady);
				this.abilityTimer.start();
			}
		}
		
		private function setAbilityReady(event:TimerEvent) {
			this.abilityTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, setAbilityReady);
			this.abilityReady = true;
			this.rgo.showMessage("Ability Ready!");
		}
	}
}
