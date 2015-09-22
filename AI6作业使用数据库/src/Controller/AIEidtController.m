//
//  AIEidtController.m
//  AI6作业使用数据库
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIEidtController.h"
#import "AICellModel.h"
#import "AIDBManager.h"
#import "FMDatabase.h"
#import "AIDefine.h"
@interface AIEidtController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property(nonatomic,strong)AIDBManager *manager;
@property(nonatomic,strong)FMDatabase *fmdb;
@end

@implementation AIEidtController

- (void)viewDidLoad {
    [super viewDidLoad];
    AICellModel *model = _messageDict[@"model"];
    _nameText.text = model.name;
    _ageText.text = [model.age stringValue];
    [_imageBtn setBackgroundImage:[UIImage imageWithData:model.imagedata] forState:(UIControlStateNormal)];
}
#pragma mark -按钮响应事件
- (IBAction)onClickBtn:(UIButton *)sender {
    //保存数据
    NSData *data = UIImagePNGRepresentation([_imageBtn backgroundImageForState:(UIControlStateNormal)]);
    _manager = [AIDBManager shareManager];
    [_manager createDBWithName:@"user"];
    NSString *sql = @"insert into userInfo(name,age,image) values(?,?,?)";
    [_manager.fmdb open];
    BOOL isSucess = [_manager.fmdb executeUpdate:sql,_nameText.text,@([_ageText.text intValue]),data];
    if (isSucess) {
        AILog(@"保存成功");
    }else{
        AILog(@"%@",_manager.fmdb.lastErrorMessage);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onClickImageBtn:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
    //跳转到相册
    [self presentViewController:picker animated:YES completion:nil];
}
- (IBAction)onClickUpdataBtn:(UIButton *)sender {
      _manager = [AIDBManager shareManager];
    [_manager createDBWithName:@"user"];
    [_manager.fmdb open];
    NSIndexPath *indexPath = _messageDict[@"indexPath"];
    
    NSString *sql = [NSString stringWithFormat:@"update userInfo set name = ?,age = ?, image = ? where id = %d",(int)indexPath.row + 1];
    NSData *data = UIImagePNGRepresentation([_imageBtn backgroundImageForState:(UIControlStateNormal)]);
    if ( [_manager.fmdb executeUpdate:sql,_nameText.text,@([_ageText.text intValue]), data]) {
        AILog(@"修改成功");
    }else{
        AILog(@"%@",_manager.fmdb.lastErrorMessage);
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [_imageBtn setBackgroundImage:image forState:(UIControlStateNormal)];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:NO];
}

@end
