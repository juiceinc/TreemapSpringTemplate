package view
{
    import flash.events.Event;
    
    import infrastructure.ApplicationPresenter;
    
    import model.AppModel;
    
    import mx.core.ClassFactory;
    
    import org.juicekit.controls.TreeMapControl;
    import org.juicekit.controls.TreeMapZoomControl;
    import org.juicekit.events.DataMouseEvent;
    
    import spark.components.ComboBox;
    import spark.components.Label;
    import spark.components.SkinnableContainer;
    
    import view.skins.TreemapContainerWhiteSkin;
    
    public class TreemapContainer extends SkinnableContainer
    {
        //------------------------------------------------------------
        //
        // Properties
        //
        //------------------------------------------------------------
                
        //------------------------------
        // Context
        //------------------------------
        private var requiredState:String;
        
        [Autowired]
        [Bindable]
        public var appModel:AppModel;
        
        
        [Bindable]
        [Autowired]
        public var applicationPresenter:ApplicationPresenter;
   
        
        //------------------------------
        // Visual Elements
        //------------------------------
        
        [SkinPart(required="true")]
        public var treemap:TreeMapControl;
        
        [SkinPart(required="false")]
        public var treemapZoomControl:TreeMapZoomControl;
        
        [SkinPart(required="false")]
        public var paletteChooser:ComboBox;
        
        [SkinPart(required="false")]
        public var currentNode:Label;
        
        [SkinPart(required="false")]
        public var titleLabel:Label;
        
        [Bindable]
        public var selectedData:Object;
        
        
        //------------------------------------------------------------
        //
        // Methods
        //
        //------------------------------------------------------------

        //------------------------------------------------------------
        //
        // Skinning
        //
        //------------------------------------------------------------
        
        private function changeState(value:String):void
        {
            requiredState = value;
            invalidateSkinState();
        }
        
        override protected function getCurrentSkinState():String
        {
            if (requiredState)
                return requiredState;
            else
                return super.getCurrentSkinState();
        }
        
        
        /**
        * Mouseover on a node.
        */
        private function overNode(e:DataMouseEvent):void {
            selectedData = e.data;
        }

        /**
         * Mouseout on a node.
         */
        private function outNode(e:DataMouseEvent):void {
            selectedData = null;
        }
        
        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);
            
            if (instance == treemap)
            {
                (instance as TreeMapControl).addEventListener(DataMouseEvent.MOUSE_OVER, overNode);
                (instance as TreeMapControl).addEventListener(DataMouseEvent.MOUSE_OUT, outNode);
            }
            else if (instance == treemapZoomControl) {
                
            }
        }
        
        override protected function partRemoved(partName:String, instance:Object):void
        {
            super.partRemoved(partName, instance);
            
            if (instance == treemap) {
                (instance as TreeMapControl).removeEventListener(DataMouseEvent.MOUSE_OVER, overNode);
                (instance as TreeMapControl).removeEventListener(DataMouseEvent.MOUSE_OUT, outNode);                
            } else if (instance == treemapZoomControl) {
            }
        }
        
        
        //------------------------------------------------------------
        //
        // Event Handling
        //
        //------------------------------------------------------------
               
        
        protected function addHandlers():void
        {
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }
        
        protected function addedToStageHandler(e:Event):void
        {
            applicationPresenter.go();
            this.setStyle('skinClass', appModel.skin);
        }

        
        //------------------------------------------------------------
        //
        // Constructor
        //
        //------------------------------------------------------------
        
        public function TreemapContainer()
        {
            this.percentWidth = 100;
            this.percentHeight = 100;
            addHandlers();
        }
                
    }
    
}


class LocalStates
{
    public static const NORMAL:String = "normal";
    public static const SEARCH:String = "search";
}
