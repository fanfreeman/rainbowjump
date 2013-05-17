package  {
	public class Cloud extends GameObject {
		
		public function Cloud() {
		}

		public function contact(rgo:RainbowGameObject) {
			if (rgo.dy < 0) {
				rgo.dy = 0;
			}
		}
		
		public function testCollision(hero:Hero) {
			if (hero.hitTestPoint(this.x - 25, this.y - 25, true) || 
				hero.hitTestPoint(this.x + 25, this.y - 25, true)) {
				return true
			}
			return false;
		}
	}
}
