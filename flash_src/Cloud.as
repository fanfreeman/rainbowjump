package  {
	public class Cloud extends Platform {
		
		public function Cloud() {
		}

		public override function contact(rgo:RainbowGameObject) {
			rgo.dy = 0;
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
