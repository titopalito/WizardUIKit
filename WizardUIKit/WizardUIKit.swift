/**********************************************************
 MIT License
 
 WizardUIKit
 
 Copyright (c) 2016 Wei-Ting Lin
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 ***********************************************************/

import UIKit

public enum AlertStatus {
    case success
    case warning
    case error
}

public enum AlertAction {
    case delete
    case add
    case save
    case overwrite
    case download
}

public enum ProgressAlertStyle {
    case activityIndicator
    case horizontalProgressBar
}

public class Wizard {
    open static let UIKit = Wizard()
    open var statusAlert: WizardStatusAlert
    open var actionAlert: WizardActionAlert
    open var imageActionAlert: WizardImageActionAlert
    open var textFieldAlert: WizardTextFieldAlert
    open var namePicker: WizardNamePickerAlert
    open var datePicker: WizardDatePickerAlert
    open var progressAlert: WizardProgressAlert
    open var indicator: WizardIndicatorAlert
    
    public init(statusAlert: WizardStatusAlert = WizardStatusAlert(), actionAlert: WizardActionAlert = WizardActionAlert(), imageActionAlert: WizardImageActionAlert = WizardImageActionAlert(), textFieldAlert: WizardTextFieldAlert = WizardTextFieldAlert(), namePicker: WizardNamePickerAlert = WizardNamePickerAlert(), datePicker: WizardDatePickerAlert = WizardDatePickerAlert(), progressAlert: WizardProgressAlert = WizardProgressAlert(), indicator: WizardIndicatorAlert = WizardIndicatorAlert()) {
        self.statusAlert      = statusAlert
        self.actionAlert      = actionAlert
        self.imageActionAlert = imageActionAlert
        self.textFieldAlert   = textFieldAlert
        self.namePicker       = namePicker
        self.datePicker       = datePicker
        self.progressAlert    = progressAlert
        self.indicator        = indicator
    }
    
    public class func showStatusAlert(alert: WizardStatusAlert, status: AlertStatus, title: String, message: String, viewController: UIViewController, completion: (() -> Void)?) {
        
        var statusOptions: WizardStatus!
        
        switch status {
        case .success:
            statusOptions = alert.successStatus
            statusOptions.titleLabel.text  = title
            statusOptions.contentLabel.text = message
        case .warning:
            statusOptions = alert.warningStatus
            statusOptions.titleLabel.text  = title
            statusOptions.contentLabel.text = message
        case .error:
            statusOptions = alert.errorStatus
            statusOptions.titleLabel.text  = title
            statusOptions.contentLabel.text = message
        }
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "StatusAlertViewController") as! StatusAlertViewController
        
        vc.statusAlert            = alert
        vc.statusOptions          = statusOptions
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didConfim = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public func showStatusAlert(withStatus status: AlertStatus, title: String, message: String, viewController: UIViewController, completion: (() -> Void)?) {
        
        var statusOptions: WizardStatus!
        
        switch status {
        case .success:
            statusOptions = statusAlert.successStatus
            statusOptions.titleLabel.text  = title
            statusOptions.contentLabel.text = message
        case .warning:
            statusOptions = statusAlert.warningStatus
            statusOptions.titleLabel.text  = title
            statusOptions.contentLabel.text = message
        case .error:
            statusOptions = statusAlert.errorStatus
            statusOptions.titleLabel.text  = title
            statusOptions.contentLabel.text = message
        }
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "StatusAlertViewController") as! StatusAlertViewController

        vc.statusAlert            = statusAlert
        vc.statusOptions          = statusOptions
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didConfim = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public class func showActionAlert(alert: WizardActionAlert, message: String, actionStyle: AlertAction, viewController: UIViewController, completion: (() -> Void)?) {
        var actionAlert = alert
        actionAlert.contentLabel.text = message
        
        switch actionStyle {
        case .save:
            actionAlert.titleLabel.text               = "Save"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardGreenColor()
            actionAlert.actionButton?.text            = "Save"
        case .add:
            actionAlert.titleLabel.text               = "Add"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardGreenColor()
            actionAlert.actionButton?.text            = "Add"
        case .download:
            actionAlert.titleLabel.text               = "Download"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardGreenColor()
            actionAlert.actionButton?.text            = "Download"
        case .overwrite:
            actionAlert.titleLabel.text               = "Overwrite"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardRedColor()
            actionAlert.actionButton?.text            = "Overwrite"
        case .delete:
            actionAlert.titleLabel.text               = "Delete"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardRedColor()
            actionAlert.actionButton?.text            = "Delete"
        }
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ActionAlertViewController") as! ActionAlertViewController
        
        vc.actionAlert = actionAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirmAction = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public class func showActionAlert(alert: WizardActionAlert, title: String, message: String, viewController: UIViewController, completion: (() -> Void)?) {
        var actionAlert = alert
        actionAlert.titleLabel.text  = title
        actionAlert.contentLabel.text = message
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ActionAlertViewController") as! ActionAlertViewController
        vc.actionAlert = actionAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirmAction = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public func showActionAlert(message: String, actionStyle: AlertAction, viewController: UIViewController, completion: (() -> Void)?) {
        var actionAlert = self.actionAlert
        actionAlert.contentLabel.text = message
        
        switch actionStyle {
        case .save:
            actionAlert.titleLabel.text               = "Save"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardGreenColor()
            actionAlert.actionButton?.text            = "Save"
        case .add:
            actionAlert.titleLabel.text               = "Add"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardGreenColor()
            actionAlert.actionButton?.text            = "Add"
        case .download:
            actionAlert.titleLabel.text               = "Download"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardGreenColor()
            actionAlert.actionButton?.text            = "Download"
        case .overwrite:
            actionAlert.titleLabel.text               = "Overwrite"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardRedColor()
            actionAlert.actionButton?.text            = "Overwrite"
        case .delete:
            actionAlert.titleLabel.text               = "Delete"
            actionAlert.actionButton?.backgroundColor = UIColor.WizardRedColor()
            actionAlert.actionButton?.text            = "Delete"
        }
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ActionAlertViewController") as! ActionAlertViewController
        
        vc.actionAlert = actionAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirmAction = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public func showActionAlert(withTitle title: String, message: String, viewController: UIViewController, completion: (() -> Void)?) {
        var actionAlert = self.actionAlert
        actionAlert.titleLabel.text  = title
        actionAlert.contentLabel.text = message
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ActionAlertViewController") as! ActionAlertViewController
        vc.actionAlert = actionAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirmAction = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public class func showImageActionAlert(alert: WizardImageActionAlert, image: UIImage, message: String, viewController: UIViewController, completion: (() -> Void)?) {
        var imageActionAlert = alert
        imageActionAlert.image = image
        imageActionAlert.contentLabel.text  = message
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ImageActionAlertViewController") as! ImageActionAlertViewController
        
        vc.imageActionAlert = imageActionAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirmAction = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public class func showImageActionAlert(alert: WizardImageActionAlert, message: String, action: AlertAction, viewController: UIViewController, completion: (() -> Void)?) {
        var imageActionAlert = alert
        imageActionAlert.contentLabel.text = message
        
        switch action {
        case .save:
            imageActionAlert.image                        = UIImage(named: "save", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardGreenColor()
            imageActionAlert.actionButton.text            = "Save"
        case .add:
            imageActionAlert.image                        = UIImage(named: "add", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardGreenColor()
            imageActionAlert.actionButton.text            = "Add"
        case .download:
            imageActionAlert.image                        = UIImage(named: "download", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardBlueColor()
            imageActionAlert.actionButton.text            = "Download"
        case .overwrite:
            imageActionAlert.image                        = UIImage(named: "overwrite", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardRedColor()
            imageActionAlert.actionButton.text            = "Overwrite"
        case .delete:
            imageActionAlert.image                        = UIImage(named: "delete", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardRedColor()
            imageActionAlert.actionButton.text            = "Delete"
        }
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ImageActionAlertViewController") as! ImageActionAlertViewController
        
        vc.imageActionAlert = imageActionAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirmAction = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public func showImageActionAlert(withImage image: UIImage, message: String, viewController: UIViewController, completion: (() -> Void)?) {
        var imageActionAlert = self.imageActionAlert
        imageActionAlert.image = image
        imageActionAlert.contentLabel.text  = message
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ImageActionAlertViewController") as! ImageActionAlertViewController
        
        vc.imageActionAlert = imageActionAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirmAction = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public func showImageActionAlert(message: String, action: AlertAction, viewController: UIViewController, completion: (() -> Void)?) {
        var imageActionAlert = self.imageActionAlert
        imageActionAlert.contentLabel.text = message
        
        switch action {
        case .save:
            imageActionAlert.image                        = UIImage(named: "save", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardGreenColor()
            imageActionAlert.actionButton.text            = "Save"
        case .add:
            imageActionAlert.image                        = UIImage(named: "add", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardGreenColor()
            imageActionAlert.actionButton.text            = "Add"
        case .download:
            imageActionAlert.image                        = UIImage(named: "download", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardBlueColor()
            imageActionAlert.actionButton.text            = "Download"
        case .overwrite:
            imageActionAlert.image                        = UIImage(named: "overwrite", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardRedColor()
            imageActionAlert.actionButton.text            = "Overwrite"
        case .delete:
            imageActionAlert.image                        = UIImage(named: "delete", in: kWizardBundle, compatibleWith: nil)!
            imageActionAlert.actionButton.backgroundColor = UIColor.WizardRedColor()
            imageActionAlert.actionButton.text            = "Delete"
        }
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ImageActionAlertViewController") as! ImageActionAlertViewController
        
        vc.imageActionAlert = imageActionAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirmAction = {
            viewController.dismiss(animated: true, completion: nil)
            if completion != nil {
                completion!()
            }
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public class func showTextFieldAlert(alert: WizardTextFieldAlert, title: String, placeholder: String, viewController: UIViewController, completion: @escaping ((String)-> Void)) {
        var textFieldAlert = alert
        textFieldAlert.titleLabel.text = title
        textFieldAlert.textField.placeholder = placeholder
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "TextFieldAlertViewController") as! TextFieldAlertViewController
        vc.textFieldAlert = textFieldAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirm = { text in
            viewController.dismiss(animated: true, completion: nil)
            completion(text)
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public func showTextFieldAlert(title: String, placeholder: String, viewController: UIViewController, completion: @escaping ((String)-> Void)) {
        var textFieldAlert = self.textFieldAlert
        textFieldAlert.titleLabel.text = title
        textFieldAlert.textField.placeholder = placeholder
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "TextFieldAlertViewController") as! TextFieldAlertViewController
        vc.textFieldAlert = textFieldAlert
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        vc.didConfirm = { text in
            viewController.dismiss(animated: true, completion: nil)
            completion(text)
        }
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public class func showNamePicker(picker: WizardNamePickerAlert,title: String, stringsForComponents:[[String]], selectedStringsForComponents:[String] = [], viewController: UIViewController, completion: @escaping ((([String], [Int]))-> Void)) {
        
        if Wizard.isNamePickerValid(stringsForComponents: stringsForComponents, selectedStringsForComponents: selectedStringsForComponents) {
            var namePicker = picker
            namePicker.titleLabel.text = title
            
            let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "NamePickerViewController") as! NamePickerViewController
            vc.stringsForComponents         = stringsForComponents
            vc.selectedStringsForComponents = selectedStringsForComponents
            vc.namePicker                   = namePicker
            vc.modalPresentationStyle       = .overCurrentContext
            vc.modalTransitionStyle         = .crossDissolve
            
            vc.didPick = { (strings, indices) in
                viewController.dismiss(animated: true, completion: nil)
                completion((strings, indices))
            }
            
            vc.didCancel = {
                viewController.dismiss(animated: true, completion: nil)
            }
            
            viewController.present(vc, animated: true, completion: nil)
        }
    }
    
    public func showNamePicker(title: String, stringsForComponents:[[String]], selectedStringsForComponents:[String] = [], viewController: UIViewController, completion: @escaping ((([String], [Int]))-> Void)) {
        
        if isNamePickerValid(stringsForComponents: stringsForComponents, selectedStringsForComponents: selectedStringsForComponents) {
            var namePicker = self.namePicker
            namePicker.titleLabel.text = title
            
            let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "NamePickerViewController") as! NamePickerViewController
            vc.stringsForComponents         = stringsForComponents
            vc.selectedStringsForComponents = selectedStringsForComponents
            vc.namePicker                   = namePicker
            vc.modalPresentationStyle       = .overCurrentContext
            vc.modalTransitionStyle         = .crossDissolve
            
            vc.didPick = { (strings, indices) in
                viewController.dismiss(animated: true, completion: nil)
                completion((strings, indices))
            }
            
            vc.didCancel = {
                viewController.dismiss(animated: true, completion: nil)
            }
            
            viewController.present(vc, animated: true, completion: nil)
        }
    }
    
    public class func showDatePicker(picker: WizardDatePickerAlert,title: String, datePickerMode: UIDatePickerMode, viewController: UIViewController, completion: @escaping (Date) -> ()) {
        var datePicker = picker
        datePicker.titleLabel.text = title
        datePicker.picker.mode = datePickerMode
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        
        vc.datePicker             = datePicker
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didPick = { selectedDate in
            viewController.dismiss(animated: true, completion: nil)
            completion(selectedDate)
        }
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public func showDatePicker(title: String, datePickerMode: UIDatePickerMode, viewController: UIViewController, completion: @escaping (Date) -> ()) {
        var datePicker = self.datePicker
        datePicker.titleLabel.text = title
        datePicker.picker.mode = datePickerMode
        
        let vc = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        
        vc.datePicker             = datePicker
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        
        vc.didPick = { selectedDate in
            viewController.dismiss(animated: true, completion: nil)
            completion(selectedDate)
        }
        
        vc.didCancel = {
            viewController.dismiss(animated: true, completion: nil)
        }
        
        viewController.present(vc, animated: true, completion: nil)
    }
    
    public class func showProgressAlert(alert: WizardProgressAlert, viewController: UIViewController) {
        let progressAlert = alert
        classProgressViewController = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ProgressViewController") as! ProgressViewController
        classProgressViewController.progressAlert          = progressAlert
        classProgressViewController.modalPresentationStyle = .overCurrentContext
        classProgressViewController.modalTransitionStyle   = .crossDissolve
        viewController.present(classProgressViewController, animated: true, completion: nil)
    }
    
    public class func setProgress(progress: Float) {
        DispatchQueue.main.async {
            if classProgressViewController != nil {
                classProgressViewController.progressView.progress = progress
            }
        }
    }
    
    public class func hideProgressAlert() {
        if classProgressViewController != nil {
            DispatchQueue.main.async {
                classProgressViewController.dismiss(animated: true, completion: nil)
                classProgressViewController = nil
            }
        }
    }
    
    private var progressViewController: ProgressViewController!
    
    public func showProgressAlert(viewController: UIViewController) {
        let progressAlert = self.progressAlert
        progressViewController = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ProgressViewController") as! ProgressViewController
        progressViewController.progressAlert          = progressAlert
        progressViewController.modalPresentationStyle = .overCurrentContext
        progressViewController.modalTransitionStyle   = .crossDissolve
        viewController.present(progressViewController, animated: true, completion: nil)
    }
    
    public func setProgress(progress: Float) {
        DispatchQueue.main.async {
            if self.progressViewController != nil {
                self.progressViewController.progressView.progress = progress
            }
        }
    }
    
    public func hideProgressAlert() {
        if self.progressViewController != nil {
            DispatchQueue.main.async {
                self.progressViewController.dismiss(animated: true, completion: nil)
                self.progressViewController = nil
            }
        }
    }
    
    public class func showIndicator(indicator: WizardIndicatorAlert,withStyle style: IndicatorStyle, viewController: UIViewController) {
        var indicator = indicator
        switch style {
        case .white:
            indicator.color = UIColor.WizardBlueColor()
            indicator.backgroundColor = .white
            indicator.dimColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        case .black:
            indicator.color = .white
            indicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            indicator.dimColor = .clear
        }
        
        classIndicatorViewController = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ActivityIndicatorAlertViewController") as! ActivityIndicatorAlertViewController
        classIndicatorViewController.indicator = indicator
        classIndicatorViewController.modalPresentationStyle = .overCurrentContext
        classIndicatorViewController.modalTransitionStyle   = .crossDissolve
        viewController.present(classIndicatorViewController, animated: true, completion: nil)
    }
    
    public class func showIndicator(indicator: WizardIndicatorAlert, viewController: UIViewController) {
        classIndicatorViewController = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ActivityIndicatorAlertViewController") as! ActivityIndicatorAlertViewController
        classIndicatorViewController.indicator = indicator
        classIndicatorViewController.modalPresentationStyle = .overCurrentContext
        classIndicatorViewController.modalTransitionStyle   = .crossDissolve
        viewController.present(classIndicatorViewController, animated: true, completion: nil)
    }
    
    public class func hideIndicator() {
        if classIndicatorViewController != nil {
            DispatchQueue.main.async {
                classIndicatorViewController.dismiss(animated: true, completion: nil)
                classIndicatorViewController = nil
            }
        }
    }

    
    private var indicatorViewController: ActivityIndicatorAlertViewController!
    
    public func showIndicator(withStyle style: IndicatorStyle, viewController: UIViewController) {
        var indicator = self.indicator
        switch style {
        case .white:
            indicator.color = UIColor.WizardBlueColor()
            indicator.backgroundColor = .white
            indicator.dimColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        case .black:
            indicator.color = .white
            indicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            indicator.dimColor = .clear
        }
        
        indicatorViewController = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ActivityIndicatorAlertViewController") as! ActivityIndicatorAlertViewController
        indicatorViewController.indicator = indicator
        indicatorViewController.modalPresentationStyle = .overCurrentContext
        indicatorViewController.modalTransitionStyle   = .crossDissolve
        viewController.present(indicatorViewController, animated: true, completion: nil)
    }
    
    public func showIndicator(viewController: UIViewController) {
        indicatorViewController = UIStoryboard(name: "Wizard", bundle: kWizardBundle).instantiateViewController(withIdentifier: "ActivityIndicatorAlertViewController") as! ActivityIndicatorAlertViewController
        indicatorViewController.indicator = indicator
        indicatorViewController.modalPresentationStyle = .overCurrentContext
        indicatorViewController.modalTransitionStyle   = .crossDissolve
        viewController.present(indicatorViewController, animated: true, completion: nil)
    }
    
    public func hideIndicator() {
        if self.indicatorViewController != nil {
            DispatchQueue.main.async {
                self.indicatorViewController.dismiss(animated: true, completion: nil)
                self.indicatorViewController = nil
            }
        }
    }
    
    private class func isNamePickerValid(stringsForComponents:[[String]], selectedStringsForComponents:[String] = []) -> Bool {
        
        if stringsForComponents.count != selectedStringsForComponents.count && !selectedStringsForComponents.isEmpty {
            print("-- Failed to show name picker because stringsForComponents.count doesn't match to selectedStringsForComponents.count")
            return false
        }
        
        for stringsForComponent in stringsForComponents {
            if stringsForComponent.isEmpty {
                print("-- Failed to show name picker because each string array in stringsForComponents must have at least one item")
                return false
            }
        }
        return true
    }
    
    private func isNamePickerValid(stringsForComponents:[[String]], selectedStringsForComponents:[String] = []) -> Bool {
        
        if stringsForComponents.count != selectedStringsForComponents.count && !selectedStringsForComponents.isEmpty {
            print("-- Failed to show name picker because stringsForComponents.count doesn't match to selectedStringsForComponents.count")
            return false
        }
        
        for stringsForComponent in stringsForComponents {
            if stringsForComponent.isEmpty {
                print("-- Failed to show name picker because each string array in stringsForComponents must have at least one item")
                return false
            }
        }
        return true
    }
}
