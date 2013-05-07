package  {
	import flash.events.*;
	
	public dynamic class Rainbow extends Platform {
		public var bouncePower:Number = 0.8;
		private var flipStep:uint;
		private var isFlipping:Boolean = false;
		
		public override function contact(rgo:RainbowGameObject) {
			// flip rainbow
			this.startFlip();
			
			// bounce up on collision
			if (this.bouncePower != 0) {
				rgo.dy = this.bouncePower;
			}
			
			// play sound effect
			rgo.playHighThud();
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
		
		public function testCollision(hero:Hero) {
			if (this.hitTestPoint(hero.x - 20, hero.y + 16, true) ||
				this.hitTestPoint(hero.x + 20, hero.y + 16, true)) {
				return true
			}
			return false;
		}
	}
}
