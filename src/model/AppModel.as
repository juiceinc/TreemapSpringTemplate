package model
{
    import flare.vis.data.Tree;
    
    import mx.collections.ArrayCollection;
    
    import org.juicekit.query.methods.*;
    
    import view.skins.TreemapContainerBlackSkin;
    import view.skins.TreemapContainerRedSkin;
    import view.skins.TreemapContainerWhiteSkin;

	[Bindable]
	public class AppModel
	{
		
		public var url:String;
        
        /**
        * Raw table data loaded from data source.
        */
        public var rawData:Array;
        

        /**
        * The class to use for the skin
        */
        public var skin:Class = TreemapContainerBlackSkin; 
        
        public function set skinName(v:String):void {
            if (v == 'white') {
                skin = TreemapContainerWhiteSkin;
            } else if (v=='red') {
                skin = TreemapContainerRedSkin;
            } else {
                skin = TreemapContainerBlackSkin;
            }
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
        public var colorField:String = 'pctChange';
        
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