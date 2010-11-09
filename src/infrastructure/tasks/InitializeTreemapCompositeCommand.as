package infrastructure.tasks
{
    import model.AppModel;
    
    import mx.controls.Alert;
    
    import org.springextensions.actionscript.core.command.CompositeCommand;
    import org.springextensions.actionscript.core.command.CompositeCommandKind;

    import org.juicekit.query.methods.*;
    
    public class InitializeTreemapCompositeCommand extends CompositeCommand
    {
        [Autowired]
        public var appModel:AppModel;

        public function InitializeTreemapCompositeCommand(appModel:AppModel):void
        {
            this.appModel = appModel;
            super(CompositeCommandKind.SEQUENCE);
        }
        
        override public function execute():*
        {
            addCommand(new FetchTreemapDataFromUrlCommand(appModel, appModel.url));
            addCommand(new SummarizeAgeBandsCommand(appModel));
            addCommand(new GenerateTreemapCommand(appModel));
            super.execute();
            
            this.dispatchCompleteEvent();
        }
        
    }
}