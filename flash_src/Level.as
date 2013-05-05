package  {
	
	public class Level {

		public var level:uint;
		public var isDistance:Boolean = false;
		public var target:uint;
		
		public function Level(level:uint) {
			this.level = level;
			
			switch (level) {
			case 1:
				this.isDistance = true;
				this.target = 100;
				break;
			case 2:
				this.isDistance = true;
				this.target = 150;
				break;
			case 3:
				this.isDistance = true;
				this.target = 200;
				break;
			default:
				this.isDistance = true;
				this.target = 500;
				break;
			}
		}

	}
}
