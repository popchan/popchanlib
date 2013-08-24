package com.popchan.display.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 *滚动窗格 可滚动任意AS3显示对象
	 *zingblue@gmail.com zingblue@163.com
	 *author chenbo,All rights reserved
	 *create 2012
	 */
	public class ScrollPane extends Component
	{
		protected var _vScrollBar:VScrollBar;
		protected var _hScrollBar:HScrollBar;
		/**背景*/
		protected var _back:Sprite;
		protected var _target:DisplayObject;
		protected var _defaultSkin:Object=
			{
				backSkin:"ScrollPaneBackSkin"
			};
		public function ScrollPane(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function preInit():void
		{
			_width=200;
			_height=200;
			_skin=_defaultSkin;
		}
		
		override protected function createChildren():void
		{
			_vScrollBar=new VScrollBar(this);
			_vScrollBar.addEventListener(Event.CHANGE,onVscrollBarChange);
			_hScrollBar=new HScrollBar(this);
			_hScrollBar.addEventListener(Event.CHANGE,onHscrollBarChange);
			
			this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
		}
		/**
		 *滚轮处理 
		 * @param event
		 * 
		 */
		protected function onMouseWheel(event:MouseEvent):void
		{
			_vScrollBar.value-=event.delta;
			onVscrollBarChange(null);
		}
		protected function onHscrollBarChange(event:Event):void
		{
			var rect:Rectangle=_target.scrollRect;
			rect.x=_hScrollBar.value;
			_target.scrollRect=rect;
		}
		
		protected function onVscrollBarChange(event:Event):void
		{
			var rect:Rectangle=_target.scrollRect;
			rect.y=_vScrollBar.value;
			_target.scrollRect=rect;
		}
		/**
		 *设置滚动目标 
		 * @param target
		 * 
		 */
		public function setScrollTarget(target:DisplayObject):void
		{
			if(_target)
				removeChild(_target);
			_target=target;	
			this.addChildAt(_target,0);
			_target.x=_target.y=0;
			_target.scrollRect=new Rectangle(0,0,_width-16,_height-16);
			
			_hScrollBar.pageScrollSize=_target.scrollRect.width;
			_hScrollBar.setScrollBarProperties(0,_target.width-_target.scrollRect.width);
			_vScrollBar.pageScrollSize=_target.scrollRect.height;
			_vScrollBar.setScrollBarProperties(0,_target.height-_target.scrollRect.height);
			
			
			
		}
		
	
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterType.SKIN))
			{
				drawBack();
				invalidate(CallLaterType.SIZE,false);
			}
			if(isCallLater(CallLaterType.SIZE))
			{
				_back.width=_width;
				_back.height=_height;
				_vScrollBar.height=_height;
				//_vScrollBar.setSize(_width,_height);
				_vScrollBar.move(_width-_vScrollBar.width,0);
				//_hScrollBar.setSize(_width,_height);
				_hScrollBar.height=_width-16;
				_hScrollBar.move(0,_width-16);
				
				
			}
			_vScrollBar.validateNow();
			_hScrollBar.validateNow();
			clearCallLater();
		}
		
		private function drawBack():void
		{
			if(_back)
				removeChild(_back);
			_back=getSkinInstance(getStyleValue("backSkin")) as Sprite;
			addChildAt(_back,0);
			
		}
		/**
		 *水平滚动条显示策略 
		 * @param value
		 * 
		 */
		public function set horizontalScrollPolicy(value:String):void
		{
			
		}
		
		/**
		 *垂直滚动条显示策略 
		 * @param value
		 * 
		 */
		public function set  verticalScrollPolicy(value:String):void
		{
			
		}
		/**
		 *当点击箭头时水平滚动条滚动像素 
		 * @param value
		 * 
		 */
		public function set horizontalLineScrollSize(value:int):void
		{
			_hScrollBar.lineScrollSize=value;
		}
		/**
		 *当点击箭头时垂直滚动条滚动像素 
		 * @param value
		 * 
		 */
		public function set verticalLineScrollSize(value:int):void
		{
			_vScrollBar.lineScrollSize=value;	
		}
		
	}
}