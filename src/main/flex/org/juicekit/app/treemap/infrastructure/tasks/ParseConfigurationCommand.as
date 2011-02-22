package org.juicekit.app.treemap.infrastructure.tasks
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;
    
    import mx.collections.ArrayCollection;
    import mx.messaging.messages.ErrorMessage;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.http.HTTPService;
    
    import org.juicekit.app.treemap.infrastructure.events.TreemapErrorEvent;
    import org.juicekit.app.treemap.model.AppModel;
    import org.juicekit.data.converter.DelimitedTextConverter;
    import org.juicekit.query.methods.*;
    import org.juicekit.util.GraphUtil;
    import org.springextensions.actionscript.core.command.ICommand;
    import org.springextensions.actionscript.core.operation.AbstractOperation;
    import org.springextensions.actionscript.core.operation.OperationEvent;
    
    /**
    * Parses a raw configuration dictionary into the appModel
    */
    public class ParseConfigurationCommand extends AbstractOperation implements ICommand
    {
        private var _appModel:AppModel;
        private var _rawConfig:Dictionary = new Dictionary();
        private var _config:Dictionary;
        
        
        public function ParseConfigurationCommand(appModel:AppModel)
        {
            super();//optional parameters: timeoutInMilliseconds, autoStartTimeout
            _appModel = appModel;
        }
        
        private function parseConfigProperty(configPropertyName:String,
                                             toPropertyName:String,
                                             dataType:Class,
                                             required:Boolean):void
        {
            if (_config.hasOwnProperty(configPropertyName)) 
            {
                if (_config[configPropertyName] is dataType) 
                    _appModel[toPropertyName] = _config[configPropertyName]; 
                else 
                    dispatchErrorEvent(new TreemapErrorEvent(OperationEvent.ERROR, false, false, configPropertyName + ' must be a ' + dataType.toString()));
            } 
            else 
            {
                if (required)
                    dispatchErrorEvent(new TreemapErrorEvent(OperationEvent.ERROR, false, false, configPropertyName + ' is required'));
            } 
                
            
        }
        
        
        public function execute():*
        {
            _config = _appModel.rawConfig;
                    
            parseConfigProperty('dataUrl', 'url', String, true);
            parseConfigProperty('levels', 'levels', Array, true);
            parseConfigProperty('sizeField', 'sizeField', String, true);
            parseConfigProperty('colorField', 'colorField', String, true);
            
            dispatchCompleteEvent();

        }
        
        
    }
}