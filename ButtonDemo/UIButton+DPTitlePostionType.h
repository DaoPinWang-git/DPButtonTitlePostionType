//
//  UIButton+DPTitlePostionType.h
//  ButtonDemo
//
//  Created by dpwong on 2017/12/18.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, DPButtonTitlePostionType) {
    DPButtonTitlePostionTypeBottom = 1,        // text below the image
    DPButtonTitlePostionTypeTop,               // text above the image
    DPButtonTitlePostionTypeLeft,              // text on the left of the image
    DPButtonTitlePostionTypeRight              // text on the right of the image
};


@interface UIButton (DPTitlePostionType)
/**
 *  @param type  the title position
 *  @param space the space between the image and text
 */
- (void)setTitlePositionWithType:(DPButtonTitlePostionType)type space:(CGFloat)space;

@end
