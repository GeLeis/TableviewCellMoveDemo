//
//  CustomCell.m
//  TableviewCellMoveDemo
//
//  Created by zhaoP on 16/9/9.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()
@end

@implementation CustomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		_press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didPress:)];
		_press.minimumPressDuration = 0.2;
		[self addGestureRecognizer:_press];
	}
	return self;
}
//
//-(void)awakeFromNib{
//	
//}


-(void)didPress:(UILongPressGestureRecognizer *)press{
	if (press.state == UIGestureRecognizerStateBegan){
		NSLog(@"begin");
		
	}else if (press.state == UIGestureRecognizerStateChanged){
		NSLog(@"changed");
		
	}else if (press.state == UIGestureRecognizerStateEnded){
		NSLog(@"end");
	}
	
	if (self.panAction) {
		self.panAction(press);
	}

}

@end
