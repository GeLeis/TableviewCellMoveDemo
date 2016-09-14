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
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
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
	CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resuseCell"];
	cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = [NSString stringWithFormat:@"%ld",[self.listData[indexPath.row] integerValue]];
	cell.imageView.image = [UIImage imageNamed:@"image"];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
	//    需要的移动行
	NSInteger fromRow = [sourceIndexPath row];
	//    获取移动某处的位置
	NSInteger toRow = [destinationIndexPath row];
	//    从数组中读取需要移动行的数据
	id object = [self.listData objectAtIndex:fromRow];
	//    在数组中移动需要移动的行的数据
	[self.listData removeObjectAtIndex:fromRow];
	//    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
	[self.listData insertObject:object atIndex:toRow];
	NSLog(@"%@",self.listData);
	
}



- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
