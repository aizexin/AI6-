//
//  AITableViewCell.m
//  AI6作业使用数据库
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AITableViewCellView.h"
#import "AICellModel.h"
#import "AIDefine.h"
#import "UIImageView+AFNetworking.h"
@implementation AITableViewCellView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(AICellModel *)data{
//    _iconImageV.image = [[UIImage imageWithData:data.imagedata]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal )];
  //  AILog(@"%@",data.imagedata);
    _iconImageV.image = [UIImage imageWithData:data.imagedata];
    _nameLabel.text = data.name;
    _ageLabel.text = [data.age stringValue];
}

@end
