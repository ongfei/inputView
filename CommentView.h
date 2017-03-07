//
//  CommentView.h
//  SinoCommunity
//
//  Created by df on 2017/3/7.
//  Copyright © 2017年 df. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^InputViewContents)(NSString *contents);

@interface CommentView : UIView

@property (nonatomic, copy) InputViewContents block;

@end
