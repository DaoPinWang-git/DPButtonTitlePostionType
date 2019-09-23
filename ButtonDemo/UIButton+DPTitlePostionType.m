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
    
//    DPExchangeImplementations(self, @selector(imageRectForContentRect:), @selector(c_imageRectForContentRect:));
//    DPExchangeImplementations(self, @selector(titleRectForContentRect:), @selector(c_titleRectForContentRect:));
    DPExchangeImplementations(self, @selector(layoutSubviews), @selector(c_layoutSubviews));
    
}

- (CGRect)c_imageRectForContentRect:(CGRect)contentRect {
    CGSize imageSize = [self c_imageSize];
    CGSize titleSize = [self c_titleSize];

    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        return [self c_imageRectForContentRect:contentRect];
    }
    CGRect rect;
    switch (self.postionType) {
        case DPButtonTitlePostionTypeBottom: {
            rect = CGRectMake((CGRectGetWidth(contentRect) - imageSize.width) / 2,
                              (CGRectGetHeight(contentRect) - titleSize.height - imageSize.height) / 2 - self.postionSpace / 2,
                              imageSize.width,
                              imageSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeTop: {
            rect = CGRectMake((CGRectGetWidth(contentRect) - imageSize.width) / 2,
                              titleSize.height + (CGRectGetHeight(contentRect) - titleSize.height - imageSize.height) / 2 + self.postionSpace / 2,
                              imageSize.width,
                              imageSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeLeft: {
            rect = CGRectMake(titleSize.width + (CGRectGetWidth(contentRect) - imageSize.width - titleSize.width) / 2  + self.postionSpace / 2,
                              (CGRectGetHeight(contentRect) - imageSize.height) / 2,
                              imageSize.width,
                              imageSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeRight: {
            
            rect = CGRectMake((CGRectGetWidth(contentRect) - imageSize.width - titleSize.width) / 2 - self.postionSpace / 2,
                              (CGRectGetHeight(contentRect) - imageSize.height) / 2,
                              imageSize.width,
                              imageSize.height);
            
            break;
        }
        default:{
            rect = [self c_imageRectForContentRect:contentRect];
        }
            break;
    }
    return rect;
}

- (CGRect)c_titleRectForContentRect:(CGRect)contentRect {
    CGSize imageSize = [self c_imageSize];
    CGSize titleSize = [self c_titleSize];
    if (CGSizeEqualToSize(titleSize, CGSizeZero)) {
        return [self c_titleRectForContentRect:contentRect];
    }
    CGRect rect;

    switch (self.postionType) {
        case DPButtonTitlePostionTypeBottom: {
            rect = CGRectMake((CGRectGetWidth(contentRect) - titleSize.width) / 2,
                              imageSize.height + (CGRectGetHeight(contentRect) - titleSize.height - imageSize.height) / 2 + self.postionSpace / 2,
                              titleSize.width,
                              titleSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeTop: {
            rect = CGRectMake((CGRectGetWidth(contentRect) - titleSize.width) / 2,
                              (CGRectGetHeight(contentRect) - titleSize.height - imageSize.height) / 2 - self.postionSpace / 2,
                              titleSize.width,
                              titleSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeLeft: {
            rect = CGRectMake((CGRectGetWidth(contentRect) - imageSize.width - titleSize.width) / 2 - self.postionSpace / 2,
                              (CGRectGetHeight(contentRect) - titleSize.height) / 2,
                              titleSize.width,
                              titleSize.height);
            
            break;
        }
        case DPButtonTitlePostionTypeRight: {
            
            rect = CGRectMake(imageSize.width + (CGRectGetWidth(contentRect) - imageSize.width - titleSize.width) / 2 + self.postionSpace / 2,
                              (CGRectGetHeight(contentRect) - titleSize.height) / 2,
                              titleSize.width,
                              titleSize.height);
            
            break;
        }
        default:{
            rect = [self c_titleRectForContentRect:contentRect];
        }
            break;
    }
    return rect;
}

- (void)c_layoutSubviews{

    // 直接调用self.imageView.image.size会触发-(CGRect)duimageRectForContentRect:(CGRect)contentRect
    // 所以需要一个中间过程绑定值
    // titleSize 同理
    UIImage *image = self.imageView.image;
    CGSize imageSize = image.size;
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(self.frame.size.width, self.titleLabel.font.lineHeight)];
//    objc_setAssociatedObject(self, @selector(c_imageSize), @(imageSize), OBJC_ASSOCIATION_RETAIN);
//    objc_setAssociatedObject(self, @selector(c_titleSize), @(titleSize), OBJC_ASSOCIATION_RETAIN);
//
//    if (!CGSizeEqualToSize(titleSize, CGSizeZero)) {
//        NSLog(@"layoutSubviews:titleSize=%@&%@",NSStringFromCGSize(titleSize),self);
//    }


     switch (self.postionType) {
        case DPButtonTitlePostionTypeBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height + self.postionSpace ,
                                                    - imageSize.width,
                                                    0.0,
                                                    0.0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0,
                                                    titleSize.width / 2,
                                                    titleSize.height + self.postionSpace,
                                                    - titleSize.width / 2);

            break;
        }
        case DPButtonTitlePostionTypeTop: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0,
                                                    - imageSize.width,
                                                    imageSize.height + self.postionSpace ,
                                                    0.0);
            self.imageEdgeInsets = UIEdgeInsetsMake(titleSize.height + self.postionSpace,
                                                    titleSize.width / 2,
                                                    0.0,
                                                    - titleSize.width / 2);



            break;
        }
        case DPButtonTitlePostionTypeLeft: {

            self.titleEdgeInsets = UIEdgeInsetsMake(.0,
                                                    - imageSize.width - self.postionSpace,
                                                    .0,
                                                    imageSize.width);
            self.imageEdgeInsets = UIEdgeInsetsMake(.0,
                                                    titleSize.width,
                                                    .0,
                                                    - titleSize.width - self.postionSpace);

            break;
        }
        case DPButtonTitlePostionTypeRight: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, self.postionSpace, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.postionSpace);


            break;
        }
        default:{
        }
            break;
    }



    [self c_layoutSubviews];
}


- (CGSize)c_titleSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (CGSize)c_imageSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}


- (DPButtonTitlePostionType)postionType{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (CGFloat)postionSpace{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}


- (void)setPostionType:(DPButtonTitlePostionType)postionType{
    objc_setAssociatedObject(self, @selector(postionType), @(postionType), OBJC_ASSOCIATION_RETAIN);
    [self setNeedsLayout];
}

- (void)setPostionSpace:(CGFloat)postionSpace{
    objc_setAssociatedObject(self, @selector(postionSpace), @(postionSpace), OBJC_ASSOCIATION_RETAIN);
    [self setNeedsLayout];
}

- (void)setTitlePositionWithType:(DPButtonTitlePostionType)type space:(CGFloat)space{
    self.postionType = type;
    self.postionSpace = space;
}


@end


