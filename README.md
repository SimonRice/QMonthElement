# QMonthElement

This is a plugin for [QuickDialog](http://escoz.com/open-source/quickdialog) (v0.9) that allows you to have an element with a month picker.  This month picker is implemented in [SRMonthPicker](https://github.com/simonrice/SRMonthPicker).  Implementation & usage is kept as similar as possible to QuickDialog's `QDateTimeElement`

## Including in your project

The easiest way by far of including this project is to use [CocoaPods](http://cocoapods.org).  Once you've got that up & running for your project, simimply add the dependency to your `Podfile`:

```ruby
platform :ios
pod 'QMonthElement'
# ...
```

Then run `pod install` to install the dependencies.  This will also include v0.9 of QuickDialog & the latest version of SRMonthPicker for you.

Alternatively, simply clone this project as a submodule or download the classes, and include them in your project.  Bear in mind the library & its dependencies use ARC, so you should create static libraries if your project doesn't.

## Usage

Usage is kept as similar as possible to QuickDialog's Date & Time elements.  There are 2 different types of elements:

* `QMonthElement`: allows you to edit a month in a new view controller that is pushed automatically.
* `QMonthInlineElement`: allows you to edit a month in the same view controller.

A quick example can be applied in any view controller that subclasses `QuickDialogController` - usually I would put this in `-(void) awakeFromNib`:

```obj-c
self.root = [[QRootElement alloc] init];
self.root.grouped = YES;
QSection *section = [[QSection alloc] init];
QMonthInlineElement *monthPicker = [[QMonthInlineElement alloc] initWithTitle:@"Month" date:[NSDate date]];

[self.root addSection:section];
[section addElement:monthPicker];
```

## Contributions

As everyone says, GitHub is about social coding - I didn't just choose to use it because of my love of git as a version control system.  Please do chip in & help make this an even better project.

## License

This library is licenced under the terms of the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).  See the `LICENSE` file or any class header for the full details.
