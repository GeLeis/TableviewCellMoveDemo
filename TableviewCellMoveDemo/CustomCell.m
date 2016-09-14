//
//  CustomCell.m
//  TableviewCellMoveDemo
//
//  Created by zhaoP on 16/9/9.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()
@property (nonatomic,strong) UIColor *bgColor;

@end

@implementation CustomCell

-(void)awakeFromNib{
	
}



//通过这三个方法来改变cell
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	NSLog(@"began");
	self.bgColor = self.backgroundColor;
	[UIView animateWithDuration:0.3 animations:^{
		self.backgroundColor = [UIColor clearColor];
	}];
	
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	NSLog(@"moved");
	//这里touches只有一个UITouch
	UITouch *touch  = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	CGPoint precisePoint = [touch preciseLocationInView:self];
	
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	NSLog(@"cancelled");
	[UIView animateWithDuration:0.3 animations:^{
		self.backgroundColor = self.bgColor;
	}];
	
}

@end
