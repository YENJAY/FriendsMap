//
//  AnnotationModel.h
//  NearFriends
//
//  Created by Leaf on 15/3/3.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnotationModel : NSObject

@property (assign,nonatomic) NSInteger index;
//纬度
@property (assign,nonatomic) double latitude;
//经度
@property (assign,nonatomic) double longitude;

@property (strong,nonatomic) NSString *userName;

@property (assign,nonatomic) CGFloat x;
@property (assign,nonatomic) CGFloat y;
@end
