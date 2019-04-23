//
//  EmailModule.swift
//  EmailModule
//
//  Created by Anton Boyarkin on 22/04/2019.
//  Copyright © 2019 iBuildApp. All rights reserved.
//

import UIKit
import AppBuilderCore
import AppBuilderCoreUI

import XMLMapper

public class EmailModule: BaseModule, ModuleType {
    public var moduleRouter: AnyRouter { return router }
    
    private var router: EmailModuleRouter!
    internal var config: WidgetModel?
    internal var data: DataModel?
    
    public override class func canHandle(config: WidgetModel) -> Bool {
        if config.type == "email" {
            return true
        }
        return false
    }
    
    public required init() {
        print("\(type(of: self)).\(#function)")
        super.init()
        router = EmailModuleRouter(with: self)
    }
    
    public func setConfig(_ model: WidgetModel) {
        self.config = model
        if let data = model.data, let dataModel = DataModel(map: data) {
            self.data = dataModel
        } else {
            print("Error parsing!")
        }
    }
}