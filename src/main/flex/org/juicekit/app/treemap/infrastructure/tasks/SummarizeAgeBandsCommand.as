package org.juicekit.app.treemap.infrastructure.tasks
{
    import org.juicekit.app.treemap.model.AppModel;
    
    import mx.collections.ArrayCollection;
    import mx.rpc.http.HTTPService;
    
    import org.juicekit.query.methods.*;
    import org.springextensions.actionscript.core.command.ICommand;
    import org.springextensions.actionscript.core.operation.AbstractOperation;
    
    /**
    * Load treemap data and summarize by age bands
    */
    public class SummarizeAgeBandsCommand extends AbstractOperation implements ICommand
    {

        private var _appModel:AppModel;

        /**
        * Constructor
        */
        public function SummarizeAgeBandsCommand(appModel:AppModel):void 
        {
            _appModel = appModel;
        }

        
        /**
         * Summarize age bands.
         */
        public function execute():*
        {
            /*
            The raw data looks like this:
            ~8000 rows
            
            STATE,SEX,AGE,POP2000,POP2008
            Alabama,M,0,30479,32055
            Alabama,M,1,29904,32321
            Alabama,M,2,30065,31789
            */
            
            // Group the ages into 10 year bands to reduce data size
            for each (var o:Object in _appModel.rawData) {
                if (o.AGE < 10) {
                    o.AGE = '0-9';
                } else if (o.AGE < 20) {
                    o.AGE = '10-19';
                } else if (o.AGE < 30) {
                    o.AGE = '20-29';
                } else if (o.AGE < 40) {
                    o.AGE = '30-39';
                } else if (o.AGE < 50) {
                    o.AGE = '40-49';
                } else if (o.AGE < 60) {
                    o.AGE = '50-59';
                } else if (o.AGE < 70) {
                    o.AGE = '60-69';
                } else if (o.AGE < 80) {
                    o.AGE = '70-79';
                } else if (o.AGE < 90) {
                    o.AGE = '80+';
                }
            }
            // resummarize by the new agebands
            _appModel.rawData = select('AGE', 'STATE', 'SEX', 
                {POP2000: sum('POP2000')}, 
                {POP2008: sum('POP2008')})
                .groupby('AGE', 'STATE', 'SEX')
                .eval(_appModel.rawData);
            
            _appModel.ac = new ArrayCollection(_appModel.rawData);
            
            dispatchCompleteEvent();
        }
        
    }
}