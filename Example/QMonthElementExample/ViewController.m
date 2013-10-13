//
// Copyright 2011-2013 ESCOZ Inc  - http://escoz.com, Simon Rice - http://www.simonrice.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
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
    
    [root addSection:section];
    [section addElement:month];
    [section addElement:monthInline];
    [section addElement:dateInline];
    self.root = root;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
