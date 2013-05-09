package  {
	
	public class RainbowFade extends Rainbow {

		private static const FadeInterval:uint = 500;
		
		private var isFaded:Boolean;
		private var fadeCounter:uint;
		
		public function RainbowFade() {
			super();
			this.fadeCounter = Math.random() * FadeInterval;
			this.isFaded = false;
		}
		
		public function updateState(timeDiff:Number):Boolean {
			this.fadeCounter += timeDiff;
			if (this.fadeCounter >= FadeInterval) {
				if (this.isFaded == false) {
					this.isFaded = true;
				} else {
					this.isFaded = false;
				}
				this.fadeCounter = 0;
			}
			return this.isFaded;
		}
	}
	
}
