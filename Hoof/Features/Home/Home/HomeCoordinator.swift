//
//  HomeCoordinator.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core
import FindFriends

class HomeCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    private let discussionModuleBuilder: DiscussionModuleBuildable
    private let findFriendsModuleBuilder: FindFriendsModuleBuildable
    
    var showDiscussion = PublishSubject<(Activity)>()
    var updateComments = PublishSubject<[Comment]?>()
    var showFindFriends = PublishSubject<Void>()
    
    init(rootViewController: NavigationControllable?, viewController: UIViewController, discussionModuleBuilder: DiscussionModuleBuildable, findFriendsModuleBuilder: FindFriendsModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.discussionModuleBuilder = discussionModuleBuilder
        self.findFriendsModuleBuilder = findFriendsModuleBuilder
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.setViewControllers([viewController], animated: true)
        
        showDiscussion.subscribe { [weak self] event in
            guard let self = self else { return }
            
            if let activity = event.element {
                guard let rootViewController = self.rootViewController, let discussionCoordinator: BaseCoordinator<[Comment]?> = self.discussionModuleBuilder.buildModule(with: rootViewController, activity: activity)?.coordinator else {
                    preconditionFailure("Cannot get signupModuleCoordinator from module builder")
                }
                
                self.coordinate(to: discussionCoordinator).subscribe(onNext: { [weak self] comments in
                    print("comments: \(comments)")
                    guard let self = self else { return }
                    
                    self.updateComments.onNext((comments))
                }).disposed(by: self.disposeBag)
            }
        }.disposed(by: disposeBag)
        
        showFindFriends.subscribe { [weak self] event in
            guard let self = self else { return }
            
            guard let rootViewController = self.rootViewController, let findFriendsCoordinator: BaseCoordinator<Void> = self.findFriendsModuleBuilder.buildModule(with: rootViewController)?.coordinator else {
                preconditionFailure("Cannot get findFriendsCoordinator from module builder")
            }
            
            self.coordinate(to: findFriendsCoordinator).subscribe(onNext: { _ in
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        return .never()
    }
}
