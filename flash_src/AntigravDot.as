package  {
	
	public class AntigravDot extends GameObject {

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
			rgo.dy = 1.5;
			
			// play sound effect
			rgo.soundControl.playGotCoin();
			// remove coin
			rgo.removeChild(this);
		}
	}
	
}
