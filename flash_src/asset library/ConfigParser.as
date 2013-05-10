package {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class ConfigParser extends MovieClip {
		
		private var configXMLPath:String;
		private var environment:String = 'loading';
		
		public function ConfigParser() {
			//Set the path of the xml file that defines the loaded images
			//if (root.loaderInfo.parameters.configXMLPath)
//			{
//				//This allows you to define the location of the config file in the embed parameters on the page
//				configXMLPath = root.loaderInfo.parameters.configXMLPath;
//			}
//			else
//			{
//				//Default to a config.xml file at the same level as the swf.
//				configXMLPath = "config.xml";
//			}
			
			configXMLPath = "config.xml";
			LoadConfigXML();
		}
		
		
		public function LoadConfigXML():void {
			var xmlURL:String = configXMLPath;
			
			var configRequest:URLRequest = new URLRequest();
			configRequest.url = xmlURL;
			
			var assetLoader:URLLoader = new URLLoader();
			assetLoader.addEventListener(Event.COMPLETE, ParseConfigXML);
			assetLoader.load(configRequest);
		}
		
		private function ParseConfigXML(e:Event):void {
		
			var configXML:XML = new XML(e.target.data);
			this.environment = configXML.environment;
			//if (configXML.title.@path)
//			{
//				addImageToStage(configXML.title.@path, Number(configXML.title.@x), Number(configXML.title.@y));
//			}
//			
//			if (configXML.images)
//			{
//				for each (var image:XML in configXML.images.*)
//				{
//					addImageToStage(image.@path, Number(image.@x), Number(image.@y));
//				}
//			}

		}
		
		public function getEnv():String {
			return this.environment;
		}
		
		private function addImageToStage(imgURL:String, imgX:Number, imgY:Number):void {
			try
			{
				var imgLoader:Loader = new Loader();
				var imageReq:URLRequest = new URLRequest(imgURL);
				imgLoader.load(imageReq);
				imgLoader.x = imgX;
				imgLoader.y = imgY;
				addChild(imgLoader);
			}
			catch (err:Error)
			{
				//Handle error here.
				trace(err.message);
			}

		}
		
	}
}