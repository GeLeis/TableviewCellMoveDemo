//
//  ViewController.m
//  TableviewCellMoveDemo
//
//  Created by zhaoP on 16/9/9.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *listData;
@property (nonatomic,assign) CGFloat translateY;
@property (nonatomic,assign) CGPoint startPoint,currentPoint;
@property (nonatomic,assign) CGRect startFrame,emptyCellFrame;
@property (nonatomic,strong) NSMutableDictionary *cells;
@end

@implementation ViewController

-(NSMutableDictionary *)cells{
	if (!_cells) {
		_cells = [NSMutableDictionary dictionary];
	}
	return _cells;
}




- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.rowHeight = 60;
	self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, 60 * 10);
	self.tableView.layer.borderWidth = 1;
	self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	
}

-(NSMutableArray *)listData{
	if (!_listData) {
		_listData = [NSMutableArray array];
		for (int i =0; i< 10; i++) {
			[_listData addObject:@(i)];
		}
	}
	return _listData;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	CustomCell *cell;
	//重用会导致快速滑动过程中交换错乱,目前不知道原因，在条目不多的情况下不才用重用即可
	cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//	cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
	cell.backgroundColor = [UIColor clearColor];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = [NSString stringWithFormat:@"%ld",[self.listData[indexPath.row] integerValue]];
	cell.imageView.image = [UIImage imageNamed:@"rocket"];
	[tableView.panGestureRecognizer requireGestureRecognizerToFail:cell.press];
	__weak typeof(cell) weakCell = cell;
	__weak typeof(self) weakSelf = self;
	
	//这里是关键
	cell.panAction = ^(UILongPressGestureRecognizer *press){
		__strong typeof(cell) stCell = weakCell;
		__strong typeof(self) stSelf = weakSelf;
		
		if (press.state == UIGestureRecognizerStateBegan){
			stSelf.startPoint = [press locationInView:tableView];
			stSelf.startFrame = stCell.frame;
			stSelf.emptyCellFrame = stCell.frame;
			stCell.layer.zPosition = 1;
		}else if (press.state == UIGestureRecognizerStateChanged){
			stSelf.currentPoint = [press locationInView:tableView];
			stCell.frame = CGRectMake(stSelf.startFrame.origin.x, stSelf.startFrame.origin.y + (self.currentPoint.y - self.startPoint.y), stSelf.startFrame.size.width, stSelf.startFrame.size.height);
			CGPoint currentCenter = stCell.center;
			CustomCell *nextCell;
			CGRect nextFrame;
			if (stSelf.currentPoint.y > stSelf.emptyCellFrame.origin.y) {
				//如果rows变化，下面if条件中的10也跟着变化
				if (((int)(currentCenter.y / stCell.frame.size.height)) > ((int)(stSelf.emptyCellFrame.origin.y / stSelf.emptyCellFrame.size.height)) && currentCenter.y < (stCell.frame.size.height * 10)) {
					nextCell = self.cells[@(((int)(stSelf.emptyCellFrame.origin.y / stSelf.emptyCellFrame.size.height)) + 1)];
				}
			}else if (stSelf.currentPoint.y < stSelf.emptyCellFrame.origin.y){
				if (((int)(currentCenter.y / stCell.frame.size.height)) < ((int)(stSelf.emptyCellFrame.origin.y / stSelf.emptyCellFrame.size.height))) {
					nextCell = self.cells[@(((int)(stSelf.emptyCellFrame.origin.y / stSelf.emptyCellFrame.size.height)) - 1)];
				}
			}
			
			if (nextCell) {
				nextFrame = nextCell.frame;
				[UIView animateWithDuration:0.3 animations:^{
					nextCell.frame = stSelf.emptyCellFrame;
				}];
				[self.cells setObject:nextCell forKey:@((int)(self.emptyCellFrame.origin.y / self.emptyCellFrame.size.height))];
				
				self.emptyCellFrame = nextFrame;
				int row = (int)(self.emptyCellFrame.origin.y / self.emptyCellFrame.size.height);
				[self.cells removeObjectForKey:@(row)];
			}
			
		}else if (press.state == UIGestureRecognizerStateEnded){
			
			[self.cells setObject:stCell forKey:@((int)(self.emptyCellFrame.origin.y / self.emptyCellFrame.size.height))];
			[UIView animateWithDuration:0.3 animations:^{
				stCell.layer.zPosition = tableView.layer.zPosition;
				stCell.frame = stSelf.emptyCellFrame;
				stSelf.emptyCellFrame = CGRectZero;
			}];
			
		}
	};
	
	[self.cells setObject:cell forKey:@(indexPath.row)];
	cell.layer.zPosition = tableView.layer.zPosition;
	return cell;
}




- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
