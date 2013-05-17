package  {
	
	public class Coin extends GameObject {

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
			// play sound effect
			rgo.soundControl.playGotCoin();
			// remove coin
			rgo.removeChild(this);
		}
	}
}
