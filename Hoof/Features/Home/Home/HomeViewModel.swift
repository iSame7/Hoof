//
//  HomeViewModel.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Core
import RxSwift

protocol HomeViewModellable: ViewModellable {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

struct HomeViewModelInputs {
    var viewState = PublishSubject<ViewState>()
    var likeButtonTapped = PublishSubject<(String, Bool)>()
}

struct HomeViewModelOutputs {
    let viewData = PublishSubject<HomeViewController.ViewData>()
}

class HomeViewModel: HomeViewModellable {
    
    let disposeBag = DisposeBag()
    let inputs = HomeViewModelInputs()
    let outputs = HomeViewModelOutputs()
    var useCase: HomeInteractable

    init(useCase: HomeInteractable) {
        self.useCase = useCase
        
        setupObservables()
    }
}

// MARK: - Observables

private extension HomeViewModel {

    func setupObservables() {
        inputs.viewState.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loaded:
                self.useCase.fetchAthleteActivties().subscribe { event in
                    switch event {
                    case let .success(posts):
                        let activities = posts.compactMap { $0 }
                        self.outputs.viewData.onNext(HomeViewController.ViewData(activities: activities))
                    case .error:
                        break
                    }
                    
                }.disposed(by: self.disposeBag)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        inputs.likeButtonTapped.subscribe(onNext: { [weak self] (postID, shouldLike) in
            guard let self = self else { return }

            if shouldLike {
                self.useCase.likePost(userID: "7", postID: postID).subscribe({ event in
                    switch event {
                    case .success:
                        print("User liked the post successfully")
                    case .error:
                    #warning("TODO: Show in app notification for graphql error")
                        break
                    }
                }).disposed(by: self.disposeBag)
            } else {
                self.useCase.unlikePost(userID: "7", postID: postID).subscribe({ event in
                    switch event {
                    case .success:
                        print("User unliked the post successfully")
                    case .error:
                    #warning("TODO: Show in app notification for graphql error")
                        break
                    }
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)
    }
}
