//
//  EmailViewController.swift
//  EmailModule
//
//  Created by Anton Boyarkin on 22/04/2019.
//

import Foundation
import AppBuilderCore
import AppBuilderCoreUI

import MessageUI

class EmailViewController: MFMailComposeViewController, BaseViewControllerType {
    var options: TransitionOptions?
    
    // MARK: - Private properties
    /// Widget type indentifier
    private var type: String?
    
    /// Widger config data
    private var data: DataModel?
    
    // MARK: - Controller life cycle methods
    public convenience init(type: String?, data: DataModel?) {
        self.init()
        self.type = type
        self.data = data
        
        if let title = self.data?.title {
            self.title = title
        }
        
        self.mailComposeDelegate = self
        
        self.navigationBar.barStyle = .default
        if var messageBody = data?.message {
            var isHtml = false
            let showLink = AppManager.manager.appModel()?.design?.isShowLink ?? false
            if showLink {
                messageBody.append("<br /><br />\(Localization.Email.Message.sentFrom) <a href=\"http://ibuildapp.com\">iBuildApp</a>")
                isHtml = true
            }
            
            self.setMessageBody(messageBody, isHTML: isHtml)
        }
        
        if let recipient = data?.mailto {
            let recipients = [recipient]
            self.setToRecipients(recipients)
        }
        
        if var subject = data?.subject {
            subject.append(" (\(Localization.Email.Message.sentFrom)iBuildApp)")
            self.setSubject(subject)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = self.data?.title {
            self.title = title
        }
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension EmailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            self.showAlertController(title: nil, message: Localization.Email.Message.success, buttonTitle: Localization.Common.Text.ok)
        case .failed:
            self.showAlertController(title: nil, message: Localization.Email.Message.Error.title, buttonTitle: Localization.Common.Text.ok)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}

class AlertMessageViewController: UIAlertController, BaseViewControllerType {
    var options: TransitionOptions?
    
    public convenience init(title: String?, message: String?) {
        self.init()
        
        self.title = title
        self.message = message
        self.addAction(UIAlertAction(title: Localization.Common.Text.ok, style: .default))
    }
    
    override var preferredStyle: UIAlertController.Style {
        return .alert
    }
}
