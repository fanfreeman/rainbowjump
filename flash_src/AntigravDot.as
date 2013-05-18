package  {
	
	public class AntigravDot extends GameObject {
		
		private var touched:Boolean = false;

		public function AntigravDot() {
			// constructor code
		}
		
		public function testCollision(hero:Hero) {
			if (this.hitTestPoint(hero.x - 20, hero.y + 16, true) ||
				this.hitTestPoint(hero.x + 20, hero.y + 16, true)) {
				return true
			}
			return false;
		}
		
		public function contact(rgo:RainbowGameObject) {
			if (!this.touched) {
				rgo.dy = rgo.level.definition.trampolineBouncePower;
				// play sound effect
				rgo.soundControl.playGotCoin();
				// remove coin
				this.visible = false;
				
				this.touched = true;
			}
		}
	}
	
}
