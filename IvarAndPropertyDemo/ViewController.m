//
//  ViewController.m
//  IvarAndPropertyDemo
//
//  Created by sunyazhou on 2020/7/14.
//  Copyright © 2020 www.sunyazhou.com. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface ClassA : NSObject {
    int _a;
    int _b;
    int _c;
    CGFloat d; //不推荐这样写
}

@property (nonatomic, strong) NSArray          *arrayA;
@property (nonatomic, copy  ) NSString         *stringA;
@property (nonatomic, assign) dispatch_queue_t testQueue;

@end

@implementation ClassA

@end

//---------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"--- class_copyPropertyList ↓↓↓---");
    ClassA *classA = [[ClassA alloc] init];
    unsigned int propertyCount;
    objc_property_t *result = class_copyPropertyList(object_getClass(classA), &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t objc_property_name = result[i];
        NSLog(@"%@",[NSString stringWithFormat:@"%s", property_getName(objc_property_name)]);
    }
    free(result);
    NSLog(@"--------------END----------------");
    
    NSLog(@"\n\n\n");
    
    NSLog(@"--- class_copyIvarList ↓↓↓---");
    Ivar *iv = class_copyIvarList(object_getClass(classA), &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        Ivar ivar = iv[i];
        NSLog(@"%@",[NSString stringWithFormat:@"%s", ivar_getName(ivar)]);
    }
    free(iv);
    NSLog(@"--------------END----------------");
}


@end
