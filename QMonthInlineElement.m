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

#import "QMonthEntryTableViewCell.h"
#import "QMonthInlineElement.h"

@implementation QMonthInlineElement {
@private
    NSNumber *_maximumYear;
    NSNumber * _minimumYear;
}

@synthesize dateValue = _dateValue;
@synthesize centerLabel = _centerLabel;
@synthesize maximumYear = _maximumYear;
@synthesize minimumYear = _minimumYear;


- (QMonthInlineElement *)init {
    self = [super init];
    _dateValue = [NSDate date];
    self.keepSelected = YES;
    return self;
}

- (QMonthInlineElement *)initWithKey:(NSString *)key {
    self = [super initWithKey:key];
    _dateValue = [NSDate date];
    self.keepSelected = YES;
    return self;
}

- (QMonthInlineElement *)initWithTitle:(NSString *)string date:(NSDate *)date {
    self = [super initWithTitle:string Value:[date description]];
    if (self!=nil){
        _dateValue = date;
    }
    return self;
}

- (void)setTicksValue:(NSNumber *)ticks {
    if (ticks!=nil)
        self.dateValue = [NSDate dateWithTimeIntervalSince1970:ticks.doubleValue];
}

- (void)setDateValue:(NSDate *)date {
    _dateValue = date;
}

-(NSNumber *)ticksValue {
    return [NSNumber numberWithDouble:[self.dateValue timeIntervalSince1970]];
}

- (QMonthInlineElement *)initWithDate:(NSDate *)date {
    return [self initWithTitle:nil date:date];
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    
    QMonthEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformMonthInlineElement"];
    if (cell==nil){
        cell = [[QMonthEntryTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];
    cell.imageView.image = self.image;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
    
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:_dateValue forKey:_key];
}

@end