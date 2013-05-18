package  {
	
	public class Goal extends GameObject {
		private var touched:Boolean = false;
		
		public function contact(rgo:RainbowGameObject) {
			if (!this.touched) {
				rgo.soundControl.playGoal();
				rgo.endLevel(true);
				this.touched = true;
			}
			
		}
	}
}
