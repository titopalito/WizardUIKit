# WizardUIKit
WizardUIKit is written with purely swift 3.0. It includes reusable and customizable UI elements such as StatusAlerts, ActionAlert, ImageActionAlert, ProgressAlert, Full Screen Activity Indicator, NamePicker and DatePicker that developers can take an advantage with so that developers do not need to make those UI again and again in different projects and apps. WizardUIKit provides common used UIs with a clean, simple and general design. You can change the design property such as images, text color, text font, background color...etc to fit your need.

# Table of contents
[Demo](#demo)  
[Requirement](#requirement)  
[Installation](#installation)  
[Usage](#usage)  
[License](#license)

# Demo
<img src="https://github.com/Tim77277/WizardUIKit/blob/master/wizardDemo.gif" width="375">

Note: Demo gif has some issue to show on Safari, please use FireFox or Chrome to view the demo for now. 

# Requirement
WizardUIKit works on iOS 9+ and requires ARC to build. It depends on the following Apple frameworks, which should already be included with most Xcode templates:
* UIKit.framework

# Installation
### Cocoapods
[CocoaPods](https://cocoapods.org) is the recommended way to add WizardUIKit to your project.

1. Add a pod entry for WizardUIKit to your Podfile 
```
pod 'WizardUIKit', :git => 'https://github.com/Tim77277/WizardUIKit.git', :tag => '1.0.16'
```

2. Install it by running pod install.
3. Include WizardUIKit with #import WizardUIKit.


# Usage
WizardUIKit is writen as a singleton, all its UIs are created when Wizard.UIKit is called at the first time. The reason why I choose to implement in this way is because when a developer changes a property of a Wizard UI, it stores the property value so that he/she doesn't need to reset the property everytime in every viewController. However, if you prefer to load Wizard UI on demand, you do not need to implement the Wizard.UIKit. But you will need to call the class function instead.

```swift
//If you prefert to load everything at once and use them everywhere, everytime in your projrect.
let wizard = Wizard.UIKit
```
_**Note: If you prefert to load each UI on demand, there is an example under StatusAlert that shows you how to load a Wizard UI on demand.**_

## StatusAlert

### - Properties
```swift
var successStatus: WizardStatus
```
A struct contains the information how StatusAlert should be displayed when status is success
```swift
var warningStatus: WizardStatus
```
A struct contains the information how StatusAlert should be displayed when status is warning
```swift
var errorStatus: WizardStatus
```
A struct contains the information how StatusAlert should be displayed when status is error
```swift
var animation: WizardAnimation
```
A struct contains the information how StatusAlert should be animated
```swift
var expandable: Bool
```
Use to set up if the StatusAlert should be expanded when the message is longer than default heigh

### - Examples
```swift
wizard.showStatusAlert(withStatus: .success, 
                            title: "Congradulation", 
                          message: "Your profile has been created successfully", 
                   viewController: self) {
  //do something after user confirm the message...
}
```

* An exmpale for loading on demand
```swift
//implement the alert and get the instance
let statusAlert = WizardStatusAlert()

//Use class function and put the alert instance into the function
Wizard.showStatusAlert(alert: statusAlert,
                      status: .success, 
                       title: "Congradulation", 
                     message: "Your profile has been created successfully", 
              viewController: self) {
  //do something after user confirm the message...
}
```

- **WizardStatus**
  * success (by default, it comes with a check mark Icon and a green button with white text color)
  * warning (by default, it comes with a exclamation point Icon and a yello button with white text color)
  * error   (by default, it comes with a cross mark Icon and a red button with white text color)

If you would like to customize the StatusAlert, you can simplely change the StatusAlert property before you call showStatusAlert function, for example the below code shows how to change successStatus button background color to black:

```swift
//change statusAlert successStatus button backgroundColor to black
wizard.statusAlert.successStatus.button.backgroundColor = .black

//show statusAlert with your style
wizard.showStatusAlert(withStatus: .success, 
                            title: "Congradulation", 
                          message: "Your profile has been created successfully", 
                   viewController: self) {
  //do something after user confirm the message...
}
```

## ActionAlert
ActionAlert comes with an action button and a cancel button.
Action button has a call back to handle the action after the user confirm the request and cancel button will dismiss the alert by itself once the user tap on the cancel button.

### - Properties
```swift
var cornerRadius: CGFloat
```
Use to change ActionAlert's cornerRadius
```swift
var backgroundColor: UIColor
```
Use to change ActionAlert's background color
```swift
var expandable: Bool
```
Use to set up if the ActionAlert should be expanded when the message is longer than default heigh
```swift
var titleLabel: WizardLabel
```
A struct contains the information how title label should be displayed on ActionAlert
```swift
var contentLabel: WizardLabel
```
A struct contains the information how message label should be displayed on ActionAlert
```swift
var cancelButton: WizardButton
```
A struct contains the information how cancel button should be displayed on ActionAlert
```swift
var actionButton: WizardButton
```
A struct contains the information how action button should be displayed on ActionAlert
```swift
var animation: WizardAnimation
```
A struct contains the information how ActionAlert should be animated

### - Examples
* **Show ActionAlert with default action**
```swift
wizard.showActionAlert(message: "Would you like to overwrite this file?", 
                        action: .overwrite, 
                viewController: self) { 
        //overwrite the file here if user wish to do so...
}
```

- **AlertAction**
  * add       (by default, it comes with a "Add" title and a green button with "Add" as its button text)
  * save      (by default, it comes with a "Save" title and a green button with "Save" as its button text)
  * delete    (by default, it comes with a "Delete" title and a red button with "Delete" as its button text)
  * overwrite (by default, it comes with a "Overwrite" title and a red button with "Overwrite" as its button text)
  * download  (by default, it comes with a "Download" title and a blue button with "Download" as its button text)
  
* **Show ActionAlert with customized action**

```swift
//change action button backgroundColor
wizard.actionAlert.actionButton.backgroundColor = .black

//show actionAlert with your style
wizard.showActionAlert(withTitle: "Connect", 
                         message: "Would you like to connect to wifi?",
                  viewController: self) { 
        //connect to wifi here if user wish to do so...
}
```

## ImageActionAlert
ImageActionAlert is idendical to ActionAlert, the only difference is it comes with an image.

### - Properties
```swift
var image: UIImage
```
Use to change ImageAlert's image
```swift
var backgroundColor: UIColor
```
Use to change ImageAlert's background color
```swift
var cornerRadius: CGFloat
```
Use to change ImageAlert's cornerRadius
```swift
var expandable: Bool
```
Use to set up if the ImageActionAlert should be expanded when the message is longer than default heigh
```swift
var contentLabel: WizardLabel
```
A struct contains the information how content label should be displayed on ImageActionAlert
```swift
var actionButton: WizardButton
```
A struct contains the information how action button should be displayed on ImageActionAlert
```swift
var animation: WizardAnimation
```
A struct contains the information how ImageActionAlert should be animated

### - Example
* **Show ImageActionAlert with default action**
```swift
wizard.showImageActionAlert(message: "Would you like to save this record?", 
                        action: .save, 
                viewController: self) { 
        //save the record here if user wish to do so...
}
```

- **AlertAction**
  * **add**       (by default, it comes with a "Add" image and a green button with "Add" as its button text)
  * **save**      (by default, it comes with a "Save" image and a green button with "Save" as its button text)
  * **delete**    (by default, it comes with a "Delete" image and a red button with "Delete" as its button text)
  * **overwrite** (by default, it comes with a "Overwrite" image and a red button with "Overwrite" as its button text)
  * **download**  (by default, it comes with a "Download" image and a blue button with "Download" as its button text)
  
* **Show ImageActionAlert with customized action**
```swift
//change action button backgroundColor
wizard.imageActionAlert.actionButton.backgroundColor = .black

//show imageActionAlert with your style
wizard.showImageActionAlert(withImage: UIImage(named: "YOURIMAGE"), 
                         message: "Would you like to connect to wifi?",
                  viewController: self) { 
        //connect to wifi here if user wish to do so...
}
```

## TextFieldAlert
### - Properties
```swift
var backgroundColor: UIColor
```
Use to change TextFieldAlert's background color
```swift
var cornerRadius: CGFloat
```
Use to change TextFieldAlert's cornerRadius
```swift
var keyboardType: UIKeyboardType
```
Use to change TextFieldAlert's keyboard type
```swift
var expandable: Bool
```
Use to set up if the ImageActionAlert should be expanded when the message is longer than default heigh
```swift
var titleLabel: WizardLabel
```
A struct contains the information how title label should be displayed on TextFieldAlert
```swift
var textField: WizardTextField
```
A struct contains the information how text field should be displayed on TextFieldAlert
```swift
var button: WizardButton
```
A struct contains the information how confirm button should be displayed on TextFieldAlert
```swift
var animation: WizardAnimation
```
A struct contains the information how ImageActionAlert should be animated

### - Example
```swift
wizard.textFieldAlert.button.text = "Submit"

wizard.showTextFieldAlert(title: "Coupon", 
                    placeholder: "Enter your coupon code...", 
                 viewController: self) { (couponCode) in
       //do something with coupon
}
```

## ProgressAlert
### - Properties
```swift
var cornerRadius: CGFloat
```
Use to change how ProgressAlert's cornerRadius
```swift
var backgroundColor: UIColor
```
Use to change how ProgressAlert's background color
```swift
var titleLabel: WizardLabel
```
A struct contains the information how title label should be displayed on ProgressAlert
```swift
var progressBar: WizardProgressBar
```
A struct contains the information how progress bar should be displayed on ProgressAlert

### - Functions
```swift
func showProgressAlert(viewController: UIViewController)
```
Use to show progress alert
```swift
func setProgress(progress: Float)
```
Use to update progress bar (Force to be executed in main thread)
```swift
func hideProgressAlert()
```
Use to hide progress bar (Force to be executed in main thread)

### - Example
```swift
//change properties before you show the progress alert
wizard.progressAlert.titleLabel.text = "Converting Data..."

//show progress alert
wizard.showProgressAlert(viewController: self)

//do something in another thread so that it won't block the main thread
doSomthingInBackground(progressHandler: { (progress) in
     //set progress
     wizard.setProgress(progress: progress)

    }, completionHandler: {
     //hide progress alert
     wizard.hideProgressAlert()
})
```

## Indicator
### - Properties
```swift
var color: UIColor
```
Use to change Indicator's color
```swift
var cornerRadius: CGFloat
```
Use to change Indicator's square-shape background corneradius
```swift
var backgroundColor : UIColor
```
Use to change Indicator's square-shape background color
```swift
var dimColor: UIColor
```
Use to change screen's color

### - Functions
```swift
func showIndicator(withStyle style: IndicatorStyle, viewController: UIViewController)
```
Show indicatoor with default styles (black, white)
```swift
func showIndicator(viewController: UIViewController)
```
Show Indicator with custom style
```swift
func hideIndicator()
```
Hide Indicator (Force to be executed in main thread)

### - Examples
* **Show Indicator with default style**
```swift
//show Indicator with white style
wizard.showIndicator(withStyle: .white, viewController: self)

//do something in another thread so that it won't block the main thread
doSomthingInBackground(completionHandler: {
    //hide Indicator after the task is finished
    wizard.hideIndicator()
})
```

* **Show Indicator with customized style**
```swift
//customize your indicator
wizard.indicator.color = .black
wizard.indicator.backgroundColor = .white

//show Indicator with your style setting
wizard.showIndicator(viewController: self)

//do something in another thread so that it won't block the main thread
doSomthingInBackground(completionHandler: {
    //hide Indicator after the task is finished
    wizard.hideIndicator()
})
```

## DatePicker
### - Properties
```swift
var backgroundColor: UIColor
```
Use to change how DatePicker's background color
```swift
var titleLabel: WizardLabel
```
A struct contains the information how title label should be displayed on DatePicker
```swift
var todayButton: WizardButton
```
A struct contains the information how today button should be displayed on DatePicker
```swift
var doneButton: WizardButton
```
A struct contains the information how done button should be displayed on DatePicker
```swift
var picker: WizardDatePicker
```
A struct contains the information how picker should be displayed on DatePicker
```swift
var animation: WizardAnimation
```
A struct contains the information how DatePicker should be animated
    
### - Example
```swift
//set up default date, datePicker will animate to this date when it shows
wizard.datePicker.picker.defaultDate = YOURDEFAULTDATE

//show datePicker
wizard.showDatePicker(title: "Select Date", 
             datePickerMode: .date, 
             viewController: self) { (selectedDate) in
       //do something with the date which user picked
}
```  

## NamePicker
### - Properties
```swift
var pickerTextColor: UIColor
```
Use to change how NamePicker's picker text color
```swift
var backgroundColor: UIColor
```
Use to change how NamePicker's background color
```swift
var titleLabel: WizardLabel
```
A struct contains the information how title label should be displayed on NamePicker
```swift
var doneButton: WizardButton
```
A struct contains the information how done button should be displayed on NamePicker
```swift
var animation: WizardAnimation
```
A struct contains the information how NamePicker should be animated

### - Examples
You can give multiple [String] as dataSet for each picker component. It returns both selected strings array and selected index array. For example, if an user select "Katie" and "Female" in the below code, it returns both ["Katie", "Female"] and [3, 1]

```swift
let names  = ["John", "David", "Billy", "Katie"]
let gender = ["Male", "Female", "Complicated"]
wizard.showNamePicker(title: "Information", 
       stringsForComponents: [names, gender], 
             viewController: self) { (strings, indices) in
    //do something with the selected information
}
```

If you want the name picker to select a certain value in the dataSet, you can call the same function with an extra parameter *selectedStringsForComponents*.

```swift
let names  = ["John", "David", "Billy", "Katie"]
let gender = ["Male", "Female", "Complicated"]
wizard.showNamePicker(title: "Information", 
       stringsForComponents: [names, gender], 
       selectedStringsForComponents: ["David", "Male"]
             viewController: self) { (strings, indices) in
    //do something with the selected information
}
```  
**Note: if a given value in selectedStringsForComponents is not found to the matched component, index 0 will be selected as default** 

# License
MIT License

Copyright (c) 2016 WEI-TING LIN

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
