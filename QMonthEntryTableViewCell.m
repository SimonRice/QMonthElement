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

#import "QMonthEntryTableViewCell.h"

SRMonthPicker *QMONTHENTRY_GLOBAL_PICKER;

@implementation QMonthEntryTableViewCell

@synthesize pickerView = _pickerView;
@synthesize centeredLabel = _centeredLabel;


- (QMonthEntryTableViewCell *)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QuickformMonthInlineElement"];
    if (self!=nil){
        [self createSubviews];
		self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return self;
}

+ (SRMonthPicker *)getPickerForDate {
    QMONTHENTRY_GLOBAL_PICKER = [[SRMonthPicker alloc] init];
    return QMONTHENTRY_GLOBAL_PICKER;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    self.selected = NO;
    _pickerView.delegate = nil;
    _pickerView = nil;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    QMonthInlineElement *const element = ((QMonthInlineElement *) _entryElement);
    
    _pickerView = [QMonthEntryTableViewCell getPickerForDate];
    _pickerView.showsSelectionIndicator = YES;
    [_pickerView sizeToFit];
    _pickerView.monthPickerDelegate = self;
    _textField.inputView = _pickerView;
    _pickerView.maximumYear = element.maximumYear;
    _pickerView.minimumYear = element.minimumYear;
    if (element.dateValue != nil)
        _pickerView.date = element.dateValue;
    
    [super textFieldDidBeginEditing:textField];
    self.selected = YES;
}

- (void)createSubviews {
    [super createSubviews];
    _textField.hidden = YES;
    
    self.centeredLabel = [[UILabel alloc] init];
    self.centeredLabel.textColor = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    self.centeredLabel.highlightedTextColor = [UIColor whiteColor];
    self.centeredLabel.font = [UIFont systemFontOfSize:17];
    self.centeredLabel.textAlignment = NSTextAlignmentCenter;
	self.centeredLabel.backgroundColor = [UIColor clearColor];
    self.centeredLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width-20, self.contentView.frame.size.height-20);
    [self.contentView addSubview:self.centeredLabel];
}

- (void)monthPickerDidChangeDate:(SRMonthPicker *)monthPicker {
    QMonthInlineElement *const element = ((QMonthInlineElement *) _entryElement);
    element.dateValue = monthPicker.date;
    [self prepareForElement:_entryElement inTableView:_quickformTableView];
    if (element.onValueChanged!=nil)
        element.onValueChanged(_entryElement);
}

- (void)prepareForElement:(QEntryElement *)element inTableView:(QuickDialogTableView *)tableView {
    [super prepareForElement:element inTableView:tableView];
    
    QMonthInlineElement *monthElement = ((QMonthInlineElement *) element);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // TODO - check for element's custom date format
    dateFormatter.dateFormat = @"MMMM y";
    
    if (!monthElement.centerLabel){
		self.textLabel.text = element.title;
        self.centeredLabel.text = nil;
		self.detailTextLabel.text = [dateFormatter stringFromDate:monthElement.dateValue];
    } else {
        self.textLabel.text = nil;
		self.centeredLabel.text = [dateFormatter stringFromDate:monthElement.dateValue];
    }
    
	_textField.text = [dateFormatter stringFromDate:monthElement.dateValue];
    _textField.placeholder = monthElement.placeholder;
    
    _textField.inputAccessoryView.hidden = monthElement.hiddenToolbar;
}

@end
