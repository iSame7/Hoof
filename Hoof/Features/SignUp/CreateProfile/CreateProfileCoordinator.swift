//
//  CreateProfileCoordinator.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class CreateProfileCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    
    init(rootViewController: NavigationControllable?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}