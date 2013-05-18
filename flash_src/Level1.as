package  {
	
	public dynamic class Level1 {
		// level attributes
		public var unitHeight:Number = 50;
		public var gravity:Number = .00158;
		public var normalBouncePower = 0.85;
		public var trampolineBouncePower = 1.1;
		public var powerTrampolineBouncePower = 1.3;
		public var cannonBouncePower = 2.4;
		
		
		public function getContents2():Array {
			var stageContents:Array = new Array();
			
			stageContents.push(new Array(Level.Generator, 6, 3, 243));
			stageContents.push(new Array(3, 			0, 				Level.Goal));
			
			return stageContents;
		}
		
		public function getContents():Array {
			var stageContents:Array = new Array();
			
			//							 +y				x				element class
			stageContents.push(new Array(3, 			-250, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Level.PlatformNormal, 5));
			
			stageContents.push(new Array(3, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 				Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 				Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Level.PlatformNormal, 5));
			
			stageContents.push(new Array(3, 			270, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(1, 			270, 			Level.Coin));
			stageContents.push(new Array(1, 			270, 			Level.Coin));
			stageContents.push(new Array(1, 			90, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(1, 			90, 			Level.Coin));
			stageContents.push(new Array(1, 			90, 			Level.Coin));
			stageContents.push(new Array(1, 			-90, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(1, 			-90, 			Level.Coin));
			stageContents.push(new Array(1, 			-90, 			Level.Coin));
			stageContents.push(new Array(1, 			-270, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(1, 			-270, 			Level.Coin));
			stageContents.push(new Array(1, 			-270, 			Level.Coin));
			stageContents.push(new Array(1, 			-90, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(1, 			-90, 			Level.Coin));
			stageContents.push(new Array(1, 			-90, 			Level.Coin));
			stageContents.push(new Array(1, 			90, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(1, 			90, 			Level.Coin));
			stageContents.push(new Array(1, 			90, 			Level.Coin));
			stageContents.push(new Array(1, 			270, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(1, 			270, 			Level.Coin));
			stageContents.push(new Array(1, 			270, 			Level.Coin));
			
			// generate random type 1, starting from y+1, ending at y+4
			stageContents.push(new Array(Level.Generator, 1, 1, 61));
			
			// generate random type 2
			// [1] size [4-5] [normal, drop] platforms per row
			stageContents.push(new Array(Level.Generator, 2, 3, 63));
			
			// generate random type 3
			// [1] size [3-4] [normal, drop, mobile, trampoline]
			stageContents.push(new Array(Level.Generator, 3, 3, 123));
			
			// centered dots
			stageContents.push(new Array(Level.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// generate random type 4
			// [1] size [3-4] [normal, drop, mobile, trampoline, power trampoline, cannon]
			stageContents.push(new Array(Level.Generator, 4, 3, 123));
			
			// centered dots
			stageContents.push(new Array(Level.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// [1] size [2-4] [normal, drop, mobile, trampoline, power trampoline, cannon]
			stageContents.push(new Array(Level.Generator, 5, 3, 243));
			
			// centered dots
			stageContents.push(new Array(Level.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// [1] size [1-3] [normal, drop, mobile, trampoline, power trampoline, cannon]
			stageContents.push(new Array(Level.Generator, 6, 3, 243));
			
			// centered dots
			stageContents.push(new Array(Level.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// goal
			stageContents.push(new Array(3, 			0, 				Level.Goal));
			
			return stageContents;
		} // eof getContents()
	}
}
