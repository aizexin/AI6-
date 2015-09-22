//
//  AITableViewController.m
//  AI6作业使用数据库
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AITableViewController.h"
#import "AICellModel.h"
#import "AIDBManager.h"
#import "AIDefine.h"
#import "AITableViewCellView.h"
#import "AIEidtController.h"
@interface AITableViewController ()
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)AIDBManager *dbManager;
@end

@implementation AITableViewController

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
  
    }
    return _dataSource;
}

-(AIDBManager *)dbManager{
    if (!_dbManager) {
        _dbManager  = [AIDBManager shareManager];
    }
    return _dbManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AILog(@"%@",NSHomeDirectory());
}


#pragma mark -读取数据从数据库中
-(void)readData{
    if (_dataSource.count > 0) {
        [_dataSource removeAllObjects];
    }
    NSString *sql = @"select * from userInfo";
    [self.dbManager.fmdb open];
    FMResultSet *result = [self.dbManager.fmdb executeQuery:sql];
    while ([result next]) {
        AICellModel *model = [AICellModel createModelWithResult:result];
        [self.dataSource addObject:model];
    }
    //刷新表格
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
//    if (animated == NO) {
        //创建数据库
        [self.dbManager createDBWithName:@"user" ];
//        return;
//    }
    [self readData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    AITableViewCellView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    AICellModel *model = self.dataSource[indexPath.row];
    cell.data = model;
    
    
    return cell;
}
#pragma mark -tabelView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _dict = @{@"indexPath":indexPath,@"model":self.dataSource[indexPath.row]};
    AIEidtController *eidtVC = [[AIEidtController alloc]init];
    eidtVC.messageDict = _dict;
    [self performSegueWithIdentifier:@"table2edit" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue.destinationViewController setValue:_dict forKey:@"messageDict"];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
