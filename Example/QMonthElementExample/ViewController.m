//
//  ViewController.m
//  QMonthElementExample
//
//  Created by Simon Rice on 17/06/2013.
//  Copyright (c) 2013 Simon Rice. All rights reserved.
//

#import <QMonthElement/QMonthElement.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Hello World";
    root.grouped = YES;
    QSection *section = [[QSection alloc] init];
    
    QMonthInlineElement *monthInline = [[QMonthInlineElement alloc] initWithTitle:@"Inline Month Element"
                                                                             date:[NSDate date]];
    QMonthElement *month = [[QMonthElement alloc] initWithTitle:@"Month Element" date:[NSDate date]];
    
    QDateTimeInlineElement *dateInline = [[QDateTimeInlineElement alloc] initWithTitle:@"Date Inline Element"
                                                                                  date:[NSDate date]
                                                                               andMode:UIDatePickerModeDate];
    QDateTimeElement *date = [[QDateTimeElement alloc] initWithTitle:@"Date Element" date:[NSDate date]];
    date.mode = UIDatePickerModeDate;
    
    [root addSection:section];
    [section addElement:month];
    [section addElement:monthInline];
    [section addElement:date];
    [section addElement:dateInline];
    self.root = root;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
