//
//  AppDelegate.h
//  FriendsMap
//
//  Created by Wang on 15/3/4.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

#define MapKey @"bP7lGbDHP0DOYi4i0gYIProb"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) BMKMapManager *manager;
@end

