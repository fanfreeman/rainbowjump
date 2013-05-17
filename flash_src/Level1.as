package  {
	
	public dynamic class Level1 {
		private static const D = 50;
		
		public function getContents():Array {
			var stageContents:Array = new Array();
			
			//							 y				x				element class
			stageContents.push(new Array(0, 			0, 				Level.PlatformMobile, 5));
			stageContents.push(new Array(D*3, 			-100, 			Level.PlatformMobile, 5));
			stageContents.push(new Array(D*5, 			-100, 			Level.Coin));
			stageContents.push(new Array(D*6, 			100, 			Level.PlatformMobile, 5));
			stageContents.push(new Array(D*8, 			100, 			Level.Coin));
			stageContents.push(new Array(D*9, 			-100, 			Level.PlatformMobile, 5));
			stageContents.push(new Array(D*11, 			-100, 			Level.Coin));
			stageContents.push(new Array(D*12, 			100, 			Level.PlatformMobile, 5));
			stageContents.push(new Array(D*14, 			100, 			Level.Coin));
			stageContents.push(new Array(D*15,			-100, 			Level.PlatformMobile, 5));
			stageContents.push(new Array(D*17, 			-100, 			Level.Coin));
			stageContents.push(new Array(D*18, 			100, 			Level.PlatformMobile, 5));
			stageContents.push(new Array(D*20, 			100, 			Level.Coin));
			stageContents.push(new Array(D*21, 			-100, 			Level.PlatformMobile, 5));
			stageContents.push(new Array(D*23, 			-100,			Level.Coin));
			
			stageContents.push(new Array(D*24, 			100, 			Level.PlatformMobile, 4));
			stageContents.push(new Array(D*27, 			100, 			Level.PlatformMobile, 3));
			stageContents.push(new Array(D*30, 			100, 			Level.PlatformMobile, 2));
			stageContents.push(new Array(D*33, 			100, 			Level.PlatformMobile, 1));
			
			stageContents.push(new Array(D*36, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*39, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*42, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*45, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*48, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*51, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*54, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*57, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*60, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*63, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*66, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*69, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*72, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*75, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*78, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*81, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*84, 			-100, 			Level.PlatformNormal, 5));
			stageContents.push(new Array(D*87, 			-100, 			Level.PlatformNormal, 5));
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
			
			stageContents.push(new Array(Level.Generator, LevelGenerator.Dots3PerRow100RowSpace, D*96, D*198));
		}
	}
}
