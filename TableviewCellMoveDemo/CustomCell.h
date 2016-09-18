//
//  CustomCell.h
//  TableviewCellMoveDemo
//
//  Created by zhaoP on 16/9/9.
//  Copyright © 2016年 langya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (nonatomic,strong) UILongPressGestureRecognizer *press;
@property (nonatomic,copy) void(^panAction)(UILongPressGestureRecognizer *press);
@end
