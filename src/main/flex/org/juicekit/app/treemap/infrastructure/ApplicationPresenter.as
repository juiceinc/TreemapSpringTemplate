package org.juicekit.app.treemap.infrastructure
{
	import flash.events.Event;
	
	import org.juicekit.app.treemap.infrastructure.tasks.FetchTreemapDataFromUrlCommand;
	import org.juicekit.app.treemap.infrastructure.tasks.InitializeTreemapCompositeCommand;
	
	import org.juicekit.app.treemap.model.AppModel;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.springextensions.actionscript.core.command.ICommand;

    
    /**
    * The application presenter receives events and dispatches the appropriate commands
    */
	public class ApplicationPresenter
	{
		private var _appModel:AppModel;
		private static var logger:ILogger = LoggerFactory.getClassLogger(ApplicationPresenter);
		
		public function ApplicationPresenter(appModel:AppModel)
		{
			_appModel = appModel;
		}

        
		/**
		 * Catches <code>loadData</code> event, triggers related command
		 */  
        [EventHandler]
		public function loadData():void
		{
			logger.debug("Trigger command to retrieve data");
            
            //var cmd:ICommand = new FetchTreemapDataFromUrlCommand(_appModel, _appModel.url);
            var cmd:ICommand = new InitializeTreemapCompositeCommand(_appModel);
			cmd.execute();
		}

        
        /**
        * Tell the presenter to start. This is a convention.
        */
        public function go():void {
            var cmd:ICommand = new InitializeTreemapCompositeCommand(_appModel);
            cmd.execute();
        }
	}
}