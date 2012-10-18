//
// Copyright 2011-2012 ESCOZ Inc  - http://escoz.com, Simon Rice - http://www.simonrice.com
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
#import "QMonthInlineElement.h"


@interface QMonthElement ()
- (void)initializeRoot;

@end

@implementation QMonthElement

@synthesize dateValue = _dateValue;

- (void)setDateValue:(NSDate *)date {
    _dateValue = date;
    self.sections = nil;
    [self initializeRoot];
}

- (void)setTicksValue:(NSNumber *)ticks {
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
    self = [self init];
    if (self!=nil){
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


- (void)initializeRoot {
    NSDate *dateForSection = _dateValue;
    if (dateForSection==nil){
        dateForSection = NSDate.date;
    }
	QSection *section = [[QSection alloc] initWithTitle:@"\n\n"];
        QMonthInlineElement *dateElement = (QMonthInlineElement *) [[QMonthInlineElement alloc] initWithKey:@"date"];
        dateElement.dateValue = dateForSection;
        dateElement.centerLabel = YES;
        dateElement.hiddenToolbar = YES;
        [section addElement:dateElement];
    [self addSection:section];
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
    
	__block QuickDialogController *controllerForBlock = newController;
    
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
