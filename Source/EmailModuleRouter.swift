//
//  EmailModuleRouter.swift
//  EmailModule
//
//  Created by Anton Boyarkin on 22/04/2019.
//

import Foundation
import AppBuilderCore
import AppBuilderCoreUI

import MessageUI

public enum EmailModuleRoute: Route {
    case root
}

public class EmailModuleRouter: BaseRouter<EmailModuleRoute> {
    var module: EmailModule?
    init(with module: EmailModule) {
        self.module = module
    }
    
    public override func generateRootViewController() -> BaseViewControllerType {
        if MFMailComposeViewController.canSendMail() {
            return EmailViewController(type: module?.config?.type, data: module?.data)
        } else {
            return AlertMessageViewController(title: NSLocalizedString("core_cannotSendEmailAlertTitle", comment: "Mail cannot be send"), message: NSLocalizedString("core_cannotSendEmailAlertMessage", comment: "This device not configured to send mail"))
        }
    }
    
    public override func prepareTransition(for route: EmailModuleRoute) -> RouteTransition {
        var options = TransitionOptions(animated: true)
        options.type = .modal
        return RouteTransition(module: generateRootViewController(), options: options)
    }
    
    public override func rootTransition() -> RouteTransition {
        return self.prepareTransition(for: .root)
    }
}
