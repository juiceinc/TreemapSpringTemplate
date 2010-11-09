package infrastructure.tasks
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    import model.AppModel;
    
    import mx.collections.ArrayCollection;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.http.HTTPService;
    
    import org.juicekit.data.converter.DelimitedTextConverter;
    import org.juicekit.query.methods.*;
    import org.juicekit.util.GraphUtil;
    import org.springextensions.actionscript.core.command.ICommand;
    import org.springextensions.actionscript.core.operation.AbstractOperation;
    
    public class GenerateTreemapCommand extends AbstractOperation implements ICommand
    {
        private var _appModel:AppModel;
        
        
        public function GenerateTreemapCommand(appModel:AppModel)
        {
            super();//optional parameters: timeoutInMilliseconds, autoStartTimeout
            _appModel = appModel;
        }
        
        
        public function execute():*
        {
            var obj:Object = {};
            var functionLookup:Object = {
                pctchange: pctchange,
                wtdaverage: wtdaverage
            }
            
            obj['size'] = sum(_appModel.sizeField);
            var colorArray = _appModel.colorField.split('__');
            if (colorArray.length > 1) {
                var func:Function = functionLookup[colorArray[0]] as Function;
                obj['color'] = func(colorArray[1], colorArray[2]);
            } else {
                obj['color'] = sum(colorArray[0]);
            }

            
            var metrics:Array = [obj];
            
            _appModel.treeData = GraphUtil.treeMap(
                _appModel.rawData,
                _appModel.levels,
                metrics);
            var x:int = 1;
        }
        
        
   }
}