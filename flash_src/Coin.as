package  {
	
	public class Coin extends GameObject {
		
		private var collected:Boolean = false;
		
		public function Coin() {
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
			if (!collected) {
				// play sound effect
				rgo.soundControl.playGotCoin();
				// remove coin
				this.visible = false;
				
				this.collected = true;
			}
		}
	}
}
