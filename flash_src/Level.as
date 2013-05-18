package  {
	import flash.utils.getDefinitionByName;
	
	public class Level {
		// stage element definitions
		public static const PlatformNormal:String = "PlatformNormal";
		public static const PlatformDrop:String = "PlatformDrop";
		public static const PlatformMobile:String = "PlatformMobile";
		public static const Trampoline:String = "Trampoline";
		public static const PowerTrampoline:String = "PowerTrampoline";
		public static const Cannon:String = "Cannon";
		public static const PowerCannon:String = "PowerCannon";
		public static const Coin:String = "Coin";
		public static const AntigravDot:String = "AntigravDot";
		public static const Goal:String = "Goal";
		// other constants
		public static const Generator:String = "Generator"; // randomly generate elements according to specification
		
		// instance vars
		public var rgo:RainbowGameObject;
		public var target:uint; // climb distance target
		private var level:uint; // level number
		public var levelElementsArray:Array;
		public var definition:*;
		//public var isDistance:Boolean = false; // this is a climb distance level
		//public var numVerticalSections:uint = 6; // number of rows per screen
		//public var yVariation:Boolean = false; // whether platform y coord is random
		//public var numPerVerticalSection:uint = 3; // number of platforms per row
		
		public function Level(level:uint) {
			this.referenceLevelClasses();
			this.level = level;
			
			switch (level) {
			case 1:
				this.target = 20000;
				break;
			default:
				this.level = 1;
				this.target = 99999;
				break;
			}
		}
		
		// parse level definition file
		public function populateStage(rgo:RainbowGameObject) {
			this.rgo = rgo;
			var levelClass:Class = getDefinitionByName("Level" + this.level) as Class;
			this.definition = new levelClass();
			var stageContents:Array = this.definition.getContents();
			var currentY:int = 0;
			this.levelElementsArray = new Array();
			// expand level definition file into level elements array
			for each (var element:Array in stageContents) {
				if (element[0] == Generator) {
					var generator:LevelGenerator = new LevelGenerator(this, element[1], currentY + element[2], currentY + element[3], this.definition.unitHeight);
					currentY += element[3];
				} else {
					currentY += element[0];
					if (element[3] == undefined) {
						this.levelElementsArray.push([currentY * this.definition.unitHeight, element[1], element[2]]);
						//this.addElement(currentY * this.definition.unitHeight, element[1], element[2]);
					} else {
						this.levelElementsArray.push([currentY * this.definition.unitHeight, element[1], element[2] + element[3]]);
						//this.addElement(currentY * this.definition.unitHeight, element[1], element[2] + element[3]);
					}
				}
			}
			
			
		}
		
		// add an element to stage
		public function addElement(y:Number, x:Number, elementClassName:String) {
			var elementClass:Class = getDefinitionByName(elementClassName) as Class;
			var element = new elementClass();
			element.setX(x);
			element.setY(y);
			if (elementClassName != "Goal") { // make things smaller
				element.scaleX = 0.6;
				element.scaleY = 0.6;
			}
			this.rgo.addChild(element);
			this.rgo.rainbowList.push(element);
			this.rgo.collisionList.addItem(element);
		}
		
		// include listed level files in swf
		private function referenceLevelClasses() {
			Level1;
		}
	}
}
