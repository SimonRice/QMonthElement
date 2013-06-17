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

// TODO: (Copied) Needs to be rewritten to use a custom UIViewController with the elements in it.
// the animation is not smooth when using the dateselector as a keyboard


#import "QMonthElement.h"


@interface QMonthElement ()

- (void)initializeRoot;
- (void)updateElements;

@end

@implementation QMonthElement

@synthesize dateValue = _dateValue;

- (void)setDateValue:(NSDate *)date {
    _dateValue = date;
    [self updateElements];
}

- (void)setTicksValue:(NSNumber *)ticks {
    if (ticks!=nil)
        [self setDateValue:[NSDate dateWithTimeIntervalSince1970:ticks.doubleValue]];
}

-(NSNumber *)ticksValue {
    return [NSNumber numberWithDouble:[self.dateValue timeIntervalSince1970]];
}

- (QMonthElement *)init {
    self = [super init];
    _grouped = YES;
    [self initializeRoot];
    return self;
}

- (QMonthElement *)initWithTitle:(NSString *)title date:(NSDate *)date {
    self = [super init];
    if (self!=nil){
        _grouped = YES;
		_title = title;
        _dateValue = date;
        [self initializeRoot];
    }
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [super getCellForTableView:tableView controller:controller];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM y";
    
    cell.detailTextLabel.text = [dateFormatter stringFromDate:_dateValue];
    
    return cell;
}

- (NSInteger)numberOfSections {
    return 1;
}

- (void)initializeRoot {
    NSDate *dateForSection = _dateValue;
    if (dateForSection==nil)
        dateForSection = NSDate.date;
        
    QSection *section = [[QSection alloc] initWithTitle:@"\n\n"];
    QMonthInlineElement *dateElement = (QMonthInlineElement *) [[QMonthInlineElement alloc] initWithKey:@"date"];
    dateElement.dateValue = dateForSection;
    dateElement.centerLabel = YES;
    dateElement.hiddenToolbar = YES;
    [section addElement:dateElement];
    [self addSection:section];
}

- (void)updateElements
{
    QMonthInlineElement *monthElement = (QMonthInlineElement *)[self elementWithKey:@"date"];
    
    NSDate *dateForElement = (_dateValue == nil) ? NSDate.date : _dateValue;
    
    if (monthElement != nil) 
        monthElement.dateValue = dateForElement;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:_dateValue forKey:_key];
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath {
    if (self.sections==nil)
        return;
    
    QuickDialogController * newController = [controller controllerForRoot:self];
    newController.quickDialogTableView.scrollEnabled = NO;
    [controller displayViewController:newController];
    
	__weak QuickDialogController *controllerForBlock = newController;
    
    newController.willDisappearCallback = ^{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        [((QSection *)[controllerForBlock.root.sections objectAtIndex:0]) fetchValueIntoObject:dict];
        
        NSDate *date;
        date = [dict valueForKey:@"date"];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
        
        self.dateValue = [[NSCalendar currentCalendar] dateFromComponents:components];
    };
    
    [newController.quickDialogTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}


@end
