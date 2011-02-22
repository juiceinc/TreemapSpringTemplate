package org.juicekit.app.treemap.infrastructure.events
{
    import flash.events.Event;
    
    import org.springextensions.actionscript.core.operation.OperationEvent;
    
    public class TreemapErrorEvent extends Event
    {
        /** A description of the error to display in the UI */
        public var errorDescription:String;
        
        
        public function TreemapErrorEvent(type:String, 
                                          bubbles:Boolean=false, 
                                          cancelable:Boolean=false, 
                                          errorDescription:String='')
        {
            super(type, bubbles, cancelable);
            this.errorDescription = errorDescription;
        }
        
        override public function clone():Event {
            return new TreemapErrorEvent(type, bubbles, cancelable, errorDescription);
        }
    }
}