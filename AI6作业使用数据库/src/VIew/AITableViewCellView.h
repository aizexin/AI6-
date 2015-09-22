//
//  AITableViewCell.h
//  AI6作业使用数据库
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AICellModel;
@interface AITableViewCellView : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageV;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property(nonatomic,strong)AICellModel *data;
@end
