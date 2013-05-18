package  {
	import flash.events.*;
	
	public dynamic class PlatformNormal extends GameObject {
		private var flipStep:uint;
		private var isFlipping:Boolean = false;
		
		public function contact(rgo:RainbowGameObject) {
			if (rgo.dy < 0) {
				rgo.dy = rgo.level.definition.normalBouncePower;
				
				// play sound effect
				var temp:Number = Math.random() * 3;
				if (temp < 1) {
					rgo.soundControl.playJump1();
				} else if (temp >= 1 && temp < 2) {
					rgo.soundControl.playJump2();
				} else if (temp >= 2 && temp < 3) {
					rgo.soundControl.playJump3();
				}
			}
		}
		
		// begin the flip
		public function startFlip() {
			isFlipping = true;
			flipStep = 10;
			this.addEventListener(Event.ENTER_FRAME, flip);
		}
		
		// take 10 steps to flip
		public function flip(event:Event) {
			flipStep--;
			
			if (flipStep > 5) { // first half of flip
				this.scaleX = 0.2 * (flipStep - 6);
			} else { // second half of flip
				this.scaleX = 0.2 * (5 - flipStep);
			}
			
			// at the end of the flip, stop the animation
			if (flipStep == 0) {
				this.removeEventListener(Event.ENTER_FRAME, flip);
			}
		}
	}
}
