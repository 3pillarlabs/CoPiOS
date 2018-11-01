//
//  ViewController.m
//  OBJCTestApp
//
//  Created by Tudor Dan Stanean on 10/27/18.
//  Copyright © 2018 Tudor Dan Stanean. All rights reserved.
//

#import "ViewController.h"
#import <TestFramework/TestFramework-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FrameworkClass testMethod];
}


@end
