package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 *水平滚动条
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class HScrollBar extends ScrollBar
	{
		public function HScrollBar(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, direction:String=SliderDirection.VERTICAL)
		{
			super(parent, x, y, SliderDirection.HORIZONTAL);
		}
	}
}