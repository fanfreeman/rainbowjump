package  {
	import flash.display.*;
	import flash.events.*;
	
	public dynamic class Rainbow extends MovieClip {
		private var flipStep:uint;
		private var isFlipping:Boolean = false;
		
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
