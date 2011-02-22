package org.juicekit.app.treemap.infrastructure.tasks
{
    import flash.events.Event;
    
    import mx.controls.Alert;
    
    import org.juicekit.app.treemap.infrastructure.events.TreemapErrorEvent;
    import org.juicekit.app.treemap.model.AppModel;
    import org.juicekit.query.methods.*;
    import org.springextensions.actionscript.core.command.CompositeCommand;
    import org.springextensions.actionscript.core.command.CompositeCommandKind;
    import org.springextensions.actionscript.core.operation.OperationEvent;
    
    public class InitializeTreemapCompositeCommand extends CompositeCommand
    {
        [Autowired]
        public var appModel:AppModel;

        public function InitializeTreemapCompositeCommand(appModel:AppModel):void
        {
            this.appModel = appModel;
            super(CompositeCommandKind.SEQUENCE);
            addErrorListener(handleError);
        }
        
        
        override public function execute():*
        {
            // Stop executing if an error is raised
            this.failOnFault = true;

            addCommand(new FetchConfigurationCommand(appModel));
            addCommand(new ParseConfigurationCommand(appModel));
            addCommand(new FetchTreemapDataFromUrlCommand(appModel));
            addCommand(new GenerateTreemapCommand(appModel));
            super.execute();
            
            this.dispatchCompleteEvent();
        }
        
        
        public function handleError(event:Event):void {
            if (event is OperationEvent && (event as OperationEvent)['error'] is TreemapErrorEvent)
                Alert.show(((event as OperationEvent).error as TreemapErrorEvent).errorDescription);
            else 
                Alert.show("Error occurred");
        }
        
    }
}