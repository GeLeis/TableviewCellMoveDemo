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
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
	[self addGestureRecognizer:pan];
}

-(void)didPan:(UIPanGestureRecognizer *)pan{
	if (self.panAction) {
		if (pan.state == UIGestureRecognizerStateBegan) {
			self.bgColor = self.backgroundColor;
			self.backgroundColor = [UIColor clearColor];
		}else if (pan.state == UIGestureRecognizerStateChanged) {
			
		}else if (pan.state == UIGestureRecognizerStateEnded) {
			self.backgroundColor = self.bgColor;
		}
		
		self.panAction(pan);
	}
}

@end
