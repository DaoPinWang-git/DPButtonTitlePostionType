//
//  UIButton+DPTitlePostionType.m
//  ButtonDemo
//
//  Created by dpwong on 2017/12/18.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "UIButton+DPTitlePostionType.h"
#import <objc/runtime.h>




@implementation UIButton (DPTitlePostionType)

void DPExchangeImplementations(Class class, SEL newSelector, SEL oldSelector) {
    Method oldMethod = class_getInstanceMethod(class, newSelector);
    Method newMethod = class_getInstanceMethod(class, oldSelector);
    method_exchangeImplementations(oldMethod, newMethod);
};


+ (void)load {
    
    DPExchangeImplementations(self, @selector(imageRectForContentRect:), @selector(c_imageRectForContentRect:));
    DPExchangeImplementations(self, @selector(titleRectForContentRect:), @selector(c_titleRectForContentRect:));
    DPExchangeImplementations(self, @selector(layoutSubviews), @selector(c_layoutSubviews));
    
}

- (CGRect)c_imageRectForContentRect:(CGRect)contentRect {
    CGSize imageSize = [self c_imageSize];
    CGSize titleSize = [self c_titleSize];
    
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        return [self c_imageRectForContentRect:contentRect];
    }
    
    switch (self.c_type) {
        case DPButtonTitlePostionTypeBottom: {
            return CGRectMake((CGRectGetWidth(contentRect) - imageSize.width) / 2,
                              (CGRectGetHeight(contentRect) - titleSize.height - imageSize.height) / 2 - self.c_space / 2,
                              imageSize.width,
                              imageSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeTop: {
            return CGRectMake((CGRectGetWidth(contentRect) - imageSize.width) / 2,
                              titleSize.height + (CGRectGetHeight(contentRect) - titleSize.height - imageSize.height) / 2 + self.c_space / 2,
                              imageSize.width,
                              imageSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeLeft: {
            return CGRectMake(titleSize.width + (CGRectGetWidth(contentRect) - imageSize.width - titleSize.width) / 2  + self.c_space / 2,
                              (CGRectGetHeight(contentRect) - imageSize.height) / 2,
                              imageSize.width,
                              imageSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeRight: {
            
            return CGRectMake((CGRectGetWidth(contentRect) - imageSize.width - titleSize.width) / 2 - self.c_space / 2,
                              (CGRectGetHeight(contentRect) - imageSize.height) / 2,
                              imageSize.width,
                              imageSize.height);
            
            break;
        }
        default:{
            return [self c_imageRectForContentRect:contentRect];
        }
            break;
    }
}

- (CGRect)c_titleRectForContentRect:(CGRect)contentRect {
    CGSize imageSize = [self c_imageSize];
    CGSize titleSize = [self c_titleSize];
    
    if (CGSizeEqualToSize(titleSize, CGSizeZero)) {
        return [self c_titleRectForContentRect:contentRect];
    }
    
    switch (self.c_type) {
        case DPButtonTitlePostionTypeBottom: {
            return CGRectMake((CGRectGetWidth(contentRect) - titleSize.width) / 2,
                              imageSize.height + (CGRectGetHeight(contentRect) - titleSize.height - imageSize.height) / 2 + self.c_space / 2,
                              titleSize.width,
                              titleSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeTop: {
            return CGRectMake((CGRectGetWidth(contentRect) - titleSize.width) / 2,
                              (CGRectGetHeight(contentRect) - titleSize.height - imageSize.height) / 2 - self.c_space / 2,
                              titleSize.width,
                              titleSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeLeft: {
            return CGRectMake((CGRectGetWidth(contentRect) - imageSize.width - titleSize.width) / 2 - self.c_space / 2,
                              (CGRectGetHeight(contentRect) - titleSize.height) / 2,
                              titleSize.width,
                              titleSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeRight: {
            
            return CGRectMake(imageSize.width + (CGRectGetWidth(contentRect) - imageSize.width - titleSize.width) / 2 + self.c_space / 2,
                              (CGRectGetHeight(contentRect) - titleSize.height) / 2,
                              titleSize.width,
                              titleSize.height);
            
            break;
        }
        default:{
            return [self c_titleRectForContentRect:contentRect];
        }
            break;
    }
}

- (void)c_layoutSubviews{
    CGSize size = self.imageView.image.size;
    objc_setAssociatedObject(self, @selector(c_imageSize), @(size), OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @selector(c_titleSize), @([self.titleLabel sizeThatFits:CGSizeMake(self.frame.size.width, self.titleLabel.font.lineHeight)]), OBJC_ASSOCIATION_RETAIN);
    
    [self c_layoutSubviews];
}

- (DPButtonTitlePostionType)c_type{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (CGFloat)c_space{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (CGSize)c_titleSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (CGSize)c_imageSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (void)setTitlePositionWithType:(DPButtonTitlePostionType)type space:(CGFloat)space
{
    
    objc_setAssociatedObject(self, @selector(c_type), @(type), OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @selector(c_space), @(space), OBJC_ASSOCIATION_RETAIN);
    
}



@end


