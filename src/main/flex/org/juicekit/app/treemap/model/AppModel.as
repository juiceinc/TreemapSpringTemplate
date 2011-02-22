package org.juicekit.app.treemap.model
{
    import flare.vis.data.Tree;
    
    import flash.utils.Dictionary;
    
    import mx.collections.ArrayCollection;
    
    import org.juicekit.app.treemap.view.skins.TreemapContainerBlackSkin;
    import org.juicekit.app.treemap.view.skins.TreemapContainerRedSkin;
    import org.juicekit.app.treemap.view.skins.TreemapContainerWhiteSkin;
    import org.juicekit.query.methods.*;

	[Bindable]
	public class AppModel
	{
        public var rawConfig:Dictionary = new Dictionary();
		
		public var url:String;
        
        /**
        * Raw table data loaded from data source.
        */
        public var rawData:Array;
        

        /**
        * The class to use for the skin
        */
        public var skin:Class = TreemapContainerWhiteSkin; 
        
        public function set skinName(v:String):void {
//            if (v == 'white') {
//                skin = TreemapContainerWhiteSkin;
//            } else if (v=='red') {
//                skin = TreemapContainerRedSkin;
//            } else {
//                skin = TreemapContainerBlackSkin;
//            }
        }
        
        /**
         * Title
         */
        public var title:String = '';
        

        public var ac:ArrayCollection;
        
        /**
        * Flare tree structured data.
        */
        public var treeData:Tree = new Tree();
        
        /**
        * Levels to use for the treemap.
        */
        public var levels:Array;
        
        /**
         * Metrics to use
         */
        public var metrics:Array = [{POP2008:sum('POP2008'), pctChange:pctchange('POP2008', 'POP2000')}];
        
        
        /**
        * Treemap colorfield
        */
        public var colorField:String = 'POP2008';
        
//        public var colorFields:String = 'pctchange__POP2008__POP2000';
//        'wtdaverage__POP2008__POP2000
//        
        public var sizeField:String = 'POP2008';
        
        
        /**
         * Color palettes to use
         */
        public var colorPalettes:ArrayCollection = new ArrayCollection(['RdGy', 'Reds']);
        
        
        public function AppModel()
		{
		}
		
		
	}
}