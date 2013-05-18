package  {
	
	public class Coin extends GameObject {
		
		private var touched:Boolean = false;
		
		public function contact(rgo:RainbowGameObject) {
			if (!touched) {
				// play sound effect
				rgo.soundControl.playGotCoin();
				// remove coin
				this.visible = false;
				
				this.touched = true;
			}
		}
	}
}
