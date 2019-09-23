//
//  EmailModuleRouter.swift
//  EmailModule
//
//  Created by Anton Boyarkin on 22/04/2019.
//

import Foundation
import IBACore
import IBACoreUI

import MessageUI

public enum EmailModuleRoute: Route {
    case root
}

public class EmailModuleRouter: BaseRouter<EmailModuleRoute> {
    var module: EmailModule?
    init(with module: EmailModule) {
        self.module = module
    }
    
    public override var hasViewController: Bool {
        return false
    }
    
    public override func generateRootViewController() -> BaseViewControllerType {
        return EmailViewController(type: module?.config?.type, data: module?.data)
    }
    
    public override func prepareTransition(for route: EmailModuleRoute) -> RouteTransition {
        var options = TransitionOptions(animated: true)
        options.type = .modal
        return RouteTransition(module: generateRootViewController(), options: options)
    }
    
    public override func rootTransition() -> RouteTransition {
        if MFMailComposeViewController.canSendMail() {
            guard let recipient = self.module?.data?.mailto, recipient.isValidEmail() else {
                if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                    rootController.showAlertController(title: Localization.Core.Message.InvalidEmailAddress.title, message: Localization.Core.Message.InvalidEmailAddress.body, buttonTitle: Localization.Common.Text.ok)
                }
                return RouteTransition()
            }
            
            return self.prepareTransition(for: .root)
        } else {
            if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                rootController.showAlertController(title: Localization.Core.Message.CantSendEmail.title, message: Localization.Core.Message.CantSendEmail.body, buttonTitle: Localization.Common.Text.ok)
            }
            return RouteTransition()
        }
    }
}
