package  {
	
	public class PowerTrampoline extends PlatformNormal {

		public function PowerTrampoline() {
			this.bouncePower = 2.3;
		}
		
		public override function contact(rgo:RainbowGameObject) {
			if (rgo.dy < 0) {
				rgo.dy = this.bouncePower;
				
				rgo.soundControl.playBoing();
				
				this.gotoAndPlay("down");
			}
		}
	}
	
}
