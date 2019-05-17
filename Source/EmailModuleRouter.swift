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
    
    public override func generateRootViewController() -> BaseViewControllerType {
        if MFMailComposeViewController.canSendMail() {
            return EmailViewController(type: module?.config?.type, data: module?.data)
        } else {
            return AlertMessageViewController(title: Localization.Core.Message.CantSendEmail.title, message: Localization.Core.Message.CantSendEmail.body)
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
