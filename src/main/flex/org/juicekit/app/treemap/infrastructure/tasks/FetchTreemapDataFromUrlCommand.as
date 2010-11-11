package org.juicekit.app.treemap.infrastructure.tasks
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.juicekit.app.treemap.model.AppModel;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.juicekit.data.converter.DelimitedTextConverter;
	import org.juicekit.query.methods.*;
	import org.springextensions.actionscript.core.command.ICommand;
	import org.springextensions.actionscript.core.operation.AbstractOperation;
	
	public class FetchTreemapDataFromUrlCommand extends AbstractOperation implements ICommand
	{
		private var _appModel:AppModel;

        /** Storage for the url to pull data from */
        private var _url:String;        
        
		public function FetchTreemapDataFromUrlCommand(appModel:AppModel, url:String)
		{
			super();//optional parameters: timeoutInMilliseconds, autoStartTimeout
            _appModel = appModel;
			_url = url;
		}
        
        
        public function execute():*
        {
            var loader:URLLoader = new URLLoader();
            
            //add event listeners
            loader.addEventListener(Event.COMPLETE, resultHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, faultHandler);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, faultHandler);
            
            loader.load(new URLRequest(_url));
            return this;
        }
        
        
        /**
         * Handle dataLoader faults
         */
        protected function faultHandler(event:FaultEvent):void {
            dispatchErrorEvent(event);
        }
            
        
        /**
         * Parse the CSV data loaded from the server.
         */
        public function resultHandler(event:Event):void {
            _appModel.rawData = new DelimitedTextConverter(',').parse(URLLoader(event.target).data as String).nodes.data;
                        
            _appModel.ac = new ArrayCollection(_appModel.rawData);
            
            dispatchCompleteEvent();
        }

	}
}