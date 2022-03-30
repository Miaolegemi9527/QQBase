//
//  QQKeyboardManager.m
//  me
//
//  Created by 子不语 on 2022/1/9.
//  Copyright © 2022 gxrb. All rights reserved.
//

#import "QQKeyboardManager.h"
#import <UIKit/UIKit.h>

QQKeyboardManager *qqKeyboardManager;

@interface QQKeyboardManager ()

@property (assign, nonatomic) CGRect keyboardFrame;
@property (nullable, nonatomic, weak) UITextView * curTextView;
@property (nullable, nonatomic, weak) UITextField *curTf;

@end

@implementation QQKeyboardManager


+ (void)load {
    [self shareInstance];
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        qqKeyboardManager = [[QQKeyboardManager alloc] init];
        [qqKeyboardManager setup];
    });
    return qqKeyboardManager;
}

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:qqKeyboardManager selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:qqKeyboardManager selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // UITextView
    [[NSNotificationCenter defaultCenter] addObserver:qqKeyboardManager selector:@selector(TextViewTextDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:qqKeyboardManager selector:@selector(TextViewTextDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
    // UITextField
    [[NSNotificationCenter defaultCenter] addObserver:qqKeyboardManager selector:@selector(TextFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:qqKeyboardManager selector:@selector(TextFieldTextDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)KeyboardWillShow:(NSNotification *)noti {
    NSValue * vv = noti.userInfo[UIKeyboardFrameEndUserInfoKey];
    self.keyboardFrame = [vv CGRectValue];
    UIView * view = [self getViewOnWindow:self.curTextView?:self.curTf];
    if (view) {
        CGRect fr = [(self.curTextView?:self.curTf).superview convertRect:(self.curTextView?:self.curTf).frame toView:[UIApplication sharedApplication].keyWindow];
        CGRect fr2 = [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
        CGFloat y = CGRectGetMaxY(fr);
        CGFloat y2 = self.keyboardFrame.origin.y;
        CGFloat y3 = y2-y-8;
        if (y3 < 0) {
            //textView提起
            [UIView animateWithDuration:0.25f animations:^{
                view.transform = CGAffineTransformMakeTranslation(fr2.origin.x, fr2.origin.y+y3);
            }];
        }
    }
}

- (void)KeyboardWillHide:(NSNotification *)noti {
//    NSLog(@"%@", noti.userInfo);
}

/** UITextView*/
- (void)TextViewTextDidBeginEditing:(NSNotification *)noti {
    self.curTextView = noti.object;
}
- (void)TextViewTextDidEndEditing:(NSNotification *)noti {
    UIView * view = [self getViewOnWindow:noti.object];
    if (view) {
        [UIView animateWithDuration:0.25f animations:^{
            view.transform = CGAffineTransformIdentity;
        }];
    }
}

/** UITextField*/
- (void)TextFieldTextDidBeginEditing:(NSNotification *)noti {
    self.curTf = noti.object;
}
- (void)TextFieldTextDidEndEditing:(NSNotification *)noti {
    UIView * view = [self getViewOnWindow:noti.object];
    if (view) {
        [UIView animateWithDuration:0.25f animations:^{
            view.transform = CGAffineTransformIdentity;
        }];
    }
}

- (UIView *)getViewOnWindow:(UIView *)view {
    UIResponder *nextResponder = view;
    while (![nextResponder isKindOfClass:[UIWindow class]]) {
        nextResponder = [nextResponder nextResponder];
        if (!nextResponder) {
            return nil;
        }
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return nil;
        }
        if (![nextResponder isKindOfClass:[UIWindow class]] && [nextResponder isKindOfClass:[UIView class]]) {
            view = (UIView *)nextResponder;
        }
    }
    return view;
}

@end
