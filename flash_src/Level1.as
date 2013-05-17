package  {
	
	public dynamic class Level1 {
		private static const D:Number = 100;
		public var unitHeight:Number = 100;
		
		public function getContents2():Array {
			var stageContents:Array = new Array();
			
			
			
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
			
			return stageContents;
		} // eof getContents()
		
		private function placeholder() {
			var stageContents:Array = new Array();
			// dots
			stageContents.push(new Array(D*24, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*26, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*28, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*30, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*32, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*34, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*36, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*38, 			0, 				Level.AntigravDot));
			//
			stageContents.push(new Array(D*41, 			0, 				Level.PlatformNormal));
			stageContents.push(new Array(D*42, 			0, 				Level.Coin));
			stageContents.push(new Array(D*43, 			0, 				Level.Coin));
			stageContents.push(new Array(D*44, 			0, 				Level.PlatformNormal));
			// 2nd group dots
			stageContents.push(new Array(D*47, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*47, 			-D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*47, 			D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*49, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*49, 			-D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*49, 			D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*51, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*51, 			-D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*51, 			D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*53, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*53, 			-D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*53, 			D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*55, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*55, 			-D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*55, 			D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*57, 			0, 				Level.AntigravDot));
			stageContents.push(new Array(D*57, 			-D*2, 			Level.AntigravDot));
			stageContents.push(new Array(D*57, 			D*2, 			Level.AntigravDot));
			
			// generate random: type 1, starting from height D*60, ending at D*86, inclusive
			stageContents.push(new Array(Level.Generator, 1, D*60, D*87));
			
			stageContents.push(new Array(D*90, 			0, 				Level.PlatformNormal));
			stageContents.push(new Array(D*91, 			0, 				Level.Coin));
			stageContents.push(new Array(D*92, 			0, 				Level.Coin));
			stageContents.push(new Array(D*93, 			0, 				Level.PlatformNormal));
			
			
		}
	}
}
