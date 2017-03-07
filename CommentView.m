//
//  CommentView.m
//  SinoCommunity
//
//  Created by df on 2017/3/7.
//  Copyright © 2017年 df. All rights reserved.
//

#import "CommentView.h"
#import "UIView+DyfAdd.h"

#define inputHeight self.frame.size.height - 4
#define inputWidth self.frame.size.width - 100
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width

#define inputBorderColor [[UIColor alloc] initWithRed:201.0/255.0 green:203.0/255.0 blue:206.0/255.0 alpha:1]
#define placeHolderLableColor [[UIColor alloc] initWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1]

#define kInputViewMaxHeight 60
#define kInputBarHeight     50

#define kKeyboardX          4
#define kKeyboardY          (kInputBarHeight-kKeyboardWidth)/2
#define kKeyboardWidth      28

#define kInputViewX         7
#define kInputViewY         7
#define kInputViewWidth     ScreenWidth/2
#define kInputViewHeight    (kInputBarHeight-kInputViewY*2)


@interface CommentView ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *inputView;

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end
@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareLayout];
        
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)prepareLayout {
    
    [self addSubview:self.inputView];
    
    [self addSubview:self.placeHolderLabel];

    
}

#pragma mark - 随着文字增多，改变布局
- (void)layout {
    
    _placeHolderLabel.hidden = _inputView.text.length > 0 ? YES : NO;
    
    CGSize textSize = [_inputView sizeThatFits:CGSizeMake(CGRectGetWidth(_inputView.frame), MAXFLOAT)];
    
    CGFloat offset = 10;
    
    _inputView.scrollEnabled = (textSize.height > kInputViewMaxHeight - offset);
    
    [_inputView setHeight:MAX(kInputViewHeight, MIN(kInputViewMaxHeight, textSize.height))];

    CGFloat maxY = CGRectGetMaxY(self.frame);
    
    [self setHeight:CGRectGetHeight(_inputView.frame)+CGRectGetMinY(_inputView.frame)*2];
    
    [self setTop:maxY - CGRectGetHeight(self.frame)];

}

#pragma mark - UITextView Delegate
- (void)textViewDidChange:(UITextView *)textView {
    [self layout];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        //点击系统键盘上的发送
        NSLog(@"%@",textView.text);
        
        if (self.block) {
            self.block(textView.text);
        }
        
        return NO;
    }
    return YES;
}

- (UITextView *)inputView {
    if (!_inputView) {
      
        _inputView = [[UITextView alloc]initWithFrame:CGRectMake(kInputViewX, kInputViewY, kInputViewWidth, kInputViewHeight)];
        
        _inputView.returnKeyType = UIReturnKeySend;
        _inputView.showsVerticalScrollIndicator = NO;
        _inputView.scrollEnabled = NO;
        _inputView.delegate = self;
        _inputView.font = [UIFont systemFontOfSize:16];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.layer.borderColor = [inputBorderColor CGColor];
        _inputView.layer.borderWidth = 0.8;
        _inputView.layer.masksToBounds = YES;
        _inputView.layer.cornerRadius = 7;
    
    }
    return _inputView;
}

- (UILabel *)placeHolderLabel {
    
    if (!_placeHolderLabel) {
        
        _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(kInputViewX+kKeyboardX, kInputViewY, kInputViewWidth-kKeyboardX, kInputViewHeight)];
       
        _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
        _placeHolderLabel.font = [UIFont systemFontOfSize:16];
        _placeHolderLabel.minimumScaleFactor = 0.9;
        _placeHolderLabel.textColor = placeHolderLableColor;
        _placeHolderLabel.userInteractionEnabled = NO;
        _placeHolderLabel.text = @"请输入内容";
    }
    return _placeHolderLabel;
}

@end
