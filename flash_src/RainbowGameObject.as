package  {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
    import flash.net.URLRequest;
	
	public class RainbowGameObject extends MovieClip {
		// constants
		public static const StageWidth:uint = 756;
		public static const StageHeight:uint = 650;
		private static const Gravity:Number = .00245;
		private static const InitialHeroX:int = -280;
		private static const InitialHeroY:int = -250;
		private static const MaxHorizontalVelocity:Number = 0.7;
		private static const PlayerMoveSpeed = 0.004;
		private static const InitialSofSpeed = 0.2;
		private static const InitialSofHeight = 0;
		private static const ScrollDownThreshold = 150;
		private static const MaxHeroFallVelocity = -1;
		
		/* instance variables */
		// config xml file
		private var configXMLPath:String;
		private var appEnv:String;
		
		// velocity
		var dx:Number;
		var dy:Number;
		
		// all platform
		var rainbowList:Array;
		
		// hero
		var hero:Hero;
		
		// distance scrolled
		var scrollDist:Number = 0;
		
		// total distance climbed
		var climbDist:Number = 0;
		// max distance climbed
		var maxDist:Number = 0;
		
		// keyboard input
		var leftArrow:Boolean = false;
		var rightArrow:Boolean = false;
		var upArrow:Boolean = false;
		var downArrow:Boolean = false;
		
		// score display
		private var gameScoreField:TextField;
		private var gameScore:int;
		
		// game time
		private var gameTimeField:TextField;
		private var gameStartTime:uint;
		private var gameTime:uint;
		
		// level finished delay timer to allow player to play a bit longer after winning
		private var delayTimer:Timer;
		
		// text to notify player that they win
		private var messageField:TextField;
		
		// whether or not to check win/lose condition
		private var checkWinLose:Boolean = true;
		
		// whether or not the player has control of the hero
		private var playerControl:Boolean = true;
		
		// the current level
		private var level:Level;
		
		// starting mouseX
		private var startingMouseX:int;
		
		// denotes whether or not the simulation should run, we use this to pause the game
		private var doSimulation:Boolean = true;
		
		// animated scrolling background
		private var bg:Background;
		
		// sea of fire height
		public var seaOfFire:SeaOfFire;
		private var seaOfFireHeight:Number = InitialSofHeight;
		private var seaOfFireSpeed:Number = InitialSofSpeed;
		
		// sound control
		public var soundControl:SoundControl;
		
		private var speedFactor:Number = 1.0;
		/* eof instance variables */
		
		public function RainbowGameObject() {
			// load configuration file
			this.configXMLPath = "config.xml";
			var configRequest:URLRequest = new URLRequest();
			configRequest.url = this.configXMLPath;
			var assetLoader:URLLoader = new URLLoader();
			assetLoader.addEventListener(Event.COMPLETE, ParseConfigXML);
			assetLoader.load(configRequest);
		}
		
		private function ParseConfigXML(e:Event):void {
			var configXML:XML = new XML(e.target.data);
			this.appEnv = configXML.environment;
			// check for swf theft
			if (this.appEnv == "dev") {
				if (this.root.loaderInfo.url.indexOf("file:///C|/Sites/rainbowjump/flash%5Fsrc/rainbow.swf") == -1) {
					trace("bad dev environment");
					return;
				}
			} else if (this.appEnv == "prod") {
				if (this.root.loaderInfo.url.indexOf("rainbowjump.herokuapp.com") == -1) {
					trace("bad prod environment");
					navigateToURL( new URLRequest("http://rainbowjump.herokuapp.com"), "_self");
					return;
				}
			} else {
				trace("config file error");
				navigateToURL( new URLRequest("http://rainbowjump.herokuapp.com"), "_self");
				return;
			}
			
			this.initialize();
		}
		
		private function initialize() {
			// list of all platforms
			this.rainbowList = new Array();
			
			// get current level and populate stage elements
			this.level = new Level(MovieClip(root).level);
			
			// create background
			this.bg = new Background(this, this.level.target);
			
			// populate stage from level file
			this.level.populateStage(this);
			
			// create sound control object
			this.soundControl = new SoundControl();
			this.soundControl.playBgm();
			
			// set original mouse position
			this.startingMouseX = mouseX;
			
			// add hero
			this.hero = new Hero(this);
			this.hero.setX(InitialHeroX);
			this.hero.setY(InitialHeroY);
			this.addChild(this.hero);
			
			// add sea of fire
			this.seaOfFire = new SeaOfFire();
			this.seaOfFire.setX(0);
			//this.seaOfFire.setY(this.seaOfFireHeight);
			this.addChild(this.seaOfFire);
			
			// add score field
			this.gameScoreField = new TextField();
			this.addChild(this.gameScoreField);
			this.gameScore = 0;
			this.showGameScore();
			
			// add time field
			this.gameTimeField = new TextField();
			this.gameTimeField.x = 660;
			this.addChild(this.gameTimeField);
			this.gameStartTime = getTimer();
			this.gameTime = 0;
			
			// initial velocity and time
			this.dx = 0.2;
			this.dy = 1.8;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		/**
		 * Set keydown states to true
		 */
		public function keyPressedDown(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				leftArrow = true;
			} else if (event.keyCode == 39) {
				rightArrow = true;
			} else if (event.keyCode == 38) {
				upArrow = true;
			} else if (event.keyCode == 40) {
				downArrow = true;
			} else if (event.keyCode == 32) { // space bar pressed
				this.hero.triggerSpecialAbility();
			}
		}
		
		/**
		 * Set keydown states to false
		 */
		public function keyPressedUp(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				leftArrow = false;
			} else if (event.keyCode == 39) {
				rightArrow = false;
			} else if (event.keyCode == 38) {
				upArrow = false;
			} else if (event.keyCode == 40) {
				downArrow = false;
			}
		}
		
		/**
		 * Move hero
		 */
		function animate(event:Event) {
			// update time
			var newTime:uint = getTimer() - this.gameStartTime;
			var timeDiff:int = newTime - this.gameTime;
			this.gameTime = newTime;
			timeDiff *= this.speedFactor;
					
			// don't run simulation if game is paused
			if (!this.doSimulation) {
				return;
			}

			// play background image
			this.bg.play(timeDiff, this.maxDist);
				
			//gameTimeField.text = "Time: " + clockTime(gameTime);
			gameTimeField.text = "Distance: " + String(Math.floor(maxDist / 10));
				
			// adjust hero vertical speed for gravity
			dy -= Gravity * timeDiff;
			if (dy < MaxHeroFallVelocity) {
				dy = MaxHeroFallVelocity;
			}
				
			// handle left and right arrow key input
			if (this.playerControl) {
				if (leftArrow) {
					dx -= PlayerMoveSpeed * timeDiff;
					if (dx < -MaxHorizontalVelocity) {
						dx = -MaxHorizontalVelocity;
					}
				}
				else if (rightArrow) {
					dx += PlayerMoveSpeed * timeDiff;
					if (dx > MaxHorizontalVelocity) {
						dx = MaxHorizontalVelocity;
					}
				}
				else {
					if (dx < 0) {
						if (Math.abs(dx) < PlayerMoveSpeed * timeDiff) {
							dx = 0;
						} else {
							dx += PlayerMoveSpeed * timeDiff;
						}
					} else if (dx > 0) {
						if (Math.abs(dx) < PlayerMoveSpeed * timeDiff) {
							dx = 0;
						} else {
							dx -= PlayerMoveSpeed * timeDiff;
						}
					}
				}
					
				//if (mouseX > this.startingMouseX) {
//						dx = (mouseX - this.startingMouseX) * timeDiff / 4000;
//						if (dx > MaxHorizontalVelocity) {
//							dx = MaxHorizontalVelocity;
//						}
//					} else if (mouseX < this.startingMouseX) {
//						dx = -(this.startingMouseX - mouseX) * timeDiff / 4000;
//						if (dx < -MaxHorizontalVelocity) {
//							dx = -MaxHorizontalVelocity;
//						}
//					}
			} // eof if (this.playerControl)
				
			// move hero
			hero.setX(hero.mx + timeDiff * dx);
			hero.setY(hero.my + timeDiff * dy);
			hero.rotation += timeDiff * dx * 1;
			this.climbDist += timeDiff * dy;
			if (this.climbDist > this.maxDist) {
				this.maxDist = this.climbDist;
			}
			
			// check for distance traveled winning condition
			if (this.checkWinLose && this.maxDist / 10 > this.level.target) {
				this.endLevel(true);
			}
				
			// move everything down
			if (this.hero.my > 0) {
				this.scrollElements(hero.my);
				this.hero.setY(0);
			}
			
			// move everything up
			if (this.hero.my < -ScrollDownThreshold) {
				this.scrollElements(hero.my + ScrollDownThreshold);
				this.hero.setY(-ScrollDownThreshold);
			}
			
			// move the sea of fire
			this.scrollSeaOfFire(timeDiff);
				
			// loop through stage elements
			for (var index:String in rainbowList) {
				// check for collision with platforms
				if (this.playerControl) {
					if (rainbowList[index].testCollision(this.hero)) { // we have a bounce
						
						// we have come in contact with this platform
						rainbowList[index].contact(this);
						
						// check if this is a fake platform
						if (Object(rainbowList[index]).constructor == RainbowGray) {
							this.removeElement(index);
						}
						
						// check if this is a mine
						if (Object(rainbowList[index]).constructor == Mine) {
							var explosion:Explosion = new Explosion();
							explosion.x = this.hero.x;
							explosion.y = this.hero.y;
							this.removeChild(this.rainbowList[index]); // remove mine
							this.addChild(explosion);
							this.soundControl.playExplosion(); // play sound
							this.playerFail();
						}
						
						// update score
						gameScore++;
						showGameScore();
					}
				}
				
				// move mobile platforms, dropping platforms and clouds
				if (this.rainbowList[index] is PlatformMobile ||
					this.rainbowList[index] is PlatformDrop ||
					this.rainbowList[index] is CloudMobile) {
					this.rainbowList[index].updatePosition(timeDiff);
				}
				
				// update state of fading platforms
				if (Object(this.rainbowList[index]).constructor == RainbowFade) {
					if (this.rainbowList[index].updateState(timeDiff)) {
						if (this.contains(this.rainbowList[index])) {
							removeChild(this.rainbowList[index]);
						}
					} else {
						if (!this.contains(this.rainbowList[index])) {
							addChild(this.rainbowList[index]);
						}
					}
				}
			} // eof loop through stage elements
				
			// we lose if we fall
			//if (this.checkWinLose && hero.my < -1 * StageHeight / 2) {
			if (this.checkWinLose && this.climbDist < this.seaOfFireHeight) {
				this.playerFail();
				return;
			}
		}
		
		/**
		 * Player fails, check to see if saves are available
		 */
		private function playerFail() {
			this.soundControl.stopBgm();
			this.soundControl.playScratch();
			this.endLevel(false);
		}
		
		/**
		 * Pause gameplay for the speicied amount in milliseconds
		 */
		private function pause(time:uint) {
			this.doSimulation = false;
			var pauseTimer:Timer = new Timer(time, 1);
			pauseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, unpause);
			pauseTimer.start();
		}
		
		/**
		 * Unpause gameplay
		 */
		private function unpause(event:TimerEvent) {
			// reset mouse position after pause
			this.startingMouseX = mouseX;
			this.doSimulation = true;
		}
		
		/**
		 * Remove a stage element from screen and garbage collect
		 */
		public function removeElement(index) {
			removeChild(this.rainbowList[index]);
			this.rainbowList[index] = null;
			this.rainbowList.splice(index, 1);
		}
		
		/**
		 * Scroll all of the rainbows downward
		 */
		public function scrollElements(distance:Number) {
			for (var index:String in rainbowList) {
				rainbowList[index].setY(rainbowList[index].my - distance);
				
				// remove a rainbow if it has scrolled below sea of fire
				if (rainbowList[index].my < (-StageHeight)) {
					this.removeElement(index);
				}
			}
			
//			this.scrollDist += distance;
//			if (this.scrollDist >= StageHeight / 2) {
//				this.addRainbows(false);
//				this.scrollDist -= StageHeight / 2;
//			}

			// populate area above visible stage with next elements in level elements array
			var PopulateSpan = StageHeight;
			while (this.level.levelElementsArray[0][0] < this.climbDist + PopulateSpan) {
				var levelElement:Array = this.level.levelElementsArray[0];
				this.level.addElement(levelElement[0] - this.climbDist, levelElement[1], levelElement[2]);
				this.level.levelElementsArray.splice(0, 1);
			}
		}
		
		private function scrollSeaOfFire(timeDiff:int) {
			this.seaOfFireHeight += timeDiff * this.seaOfFireSpeed;
			
			// adjust sea of fire
			if ((this.climbDist - this.seaOfFireHeight) > StageHeight) {
				this.seaOfFireHeight = this.climbDist - StageHeight;
			}
			
			this.seaOfFire.setY(-(this.climbDist - this.seaOfFireHeight - this.hero.my));
		}
		
		/**
		 * Display a big message on screen
		 */
		public function showMessage(message:String) {
			var myFormat:TextFormat = new TextFormat();
			myFormat.font = "Arial";
			myFormat.size = 96;
			myFormat.bold = true;
			myFormat.color = 0xFF66CC;
			myFormat.align = "center";
			this.messageField = new TextField();
			this.messageField.defaultTextFormat = myFormat;
			this.messageField.selectable = false;
			this.messageField.y = 240;
			this.messageField.text = message;
			this.messageField.width = StageWidth;
			this.addChild(this.messageField);
			
			var messageTimer:Timer = new Timer(2000, 1);
			messageTimer.addEventListener(TimerEvent.TIMER_COMPLETE, hideMessage);
			messageTimer.start();
		}
		
		/**
		 * Hide the big message on screen
		 */
		public function hideMessage(event:TimerEvent) {
			this.removeChild(this.messageField);
		}
		
		/**
		 * Finish playing the current level
		 */
		public function endLevel(isVictory:Boolean) {
			// stop checking win/lose condition
			this.checkWinLose = false;
			
			if (isVictory) {
				// add win notify field
				this.showMessage("You Win!");
			
				this.delayTimer = new Timer(3000, 1);
				this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endGame);
				this.delayTimer.start();
				
				// update level
				MovieClip(root).level += 1;
			} else { // player loses
				// revoke player control of hero
				this.playerControl = false;
				
				// add win notify field
				this.showMessage("You Lose");
			
				this.delayTimer = new Timer(3000, 1);
				this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endGame);
				this.delayTimer.start();
			}
		}
		
		/**
		 * Clean up the stage and end game
		 */
		public function endGame(event:TimerEvent) {
			if (event != null) {
				this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, endGame);
			}
			this.removeEventListener(Event.ENTER_FRAME, animate);
			for (var indexRemove:String in this.rainbowList) {
				//this.removeChild(this.rainbowList[indexRemove]); // cannot remove here because glass rainbows are already removed
				this.rainbowList[indexRemove] = null;
			}
			this.removeChild(this.hero);
			this.hero = null;
			
			// stop background music
			this.soundControl.stopBgm();

			MovieClip(root).gameScore = gameScore;
			MovieClip(root).gameTime = clockTime(gameTime);
			MovieClip(root).gotoAndStop("gameover");
		}
		
		/**
		 * Convert custom coordinates to Flash stage coordinates
		 */
		public static function getStageX(x:int) {
			if (x < -1 * StageWidth / 2) {
				x += StageWidth;
			}
			else if (x >= StageWidth / 2) {
				x -= StageWidth;
			}
			
			return StageWidth / 2 + x;
		}
		
		/**
		 * Convert custom coordinates to Flash stage coordinates
		 */
		public static function getStageY(y:int) {
			return StageHeight / 2 - y;
		}
		
		/**
		 * Display the game score
		 */
		public function showGameScore() {
			gameScoreField.text = "Score: " + String(gameScore);
		}
		
		/**
		 * Provides a nicely formatted time display given input in milliseconds
		 */
		 public function clockTime(ms:int) {
			 var seconds:int = Math.floor(ms / 1000);
			 var minutes:int = Math.floor(seconds / 60);
			 seconds -= minutes * 60;
			 var timeString:String = minutes + ":" + String(seconds + 100).substr(1, 2);
			 return timeString;
		 }
	}
}
