//
//  FindFriendsUseCase.swift
//  FindFriends
//
//  Created Sameh Mabrouk on 24/02/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

public protocol FindFriendsInteractable {
    func fetchSuggestedAthletes(userID: Int) -> Single<[User?]>
    func followUser(userID: String, userToFollowID: String) -> Single<Bool>
    func unfollowUser(userID: String, userToUnfollowID: String) -> Single<Bool>
    func searchUsers(query: String) -> Single<[User?]>
    func followAll(userID: String, usersIdsToFollow: [String]) -> Single<Bool>
    func unfollowAll(userID: String, usersIdsToUnfollow: [String]) -> Single<Bool>
}

class FindFriendsUseCase: FindFriendsInteractable {

    private let service: FindFriendsServicePerforming
    
    init(service: FindFriendsServicePerforming) {
        self.service = service
    }
    
    func fetchSuggestedAthletes(userID: Int) -> Single<[User?]> {
        service.fetchSuggestedAthletes(userID: userID)
    }
    
    func followUser(userID: String, userToFollowID: String) -> Single<Bool> {
        service.followUser(userID: userID, userToFollowID: userToFollowID)
    }
    
    func unfollowUser(userID: String, userToUnfollowID: String) -> Single<Bool> {
        service.unfollowUser(userID: userID, userToUnfollowID: userToUnfollowID)
    }
    
    func searchUsers(query: String) -> Single<[User?]> {
        service.searchUsers(query: query)
    }
    
    func followAll(userID: String, usersIdsToFollow: [String]) -> Single<Bool> {
        service.followAll(userID: userID, usersIdsToFollow: usersIdsToFollow)
    }
    
    func unfollowAll(userID: String, usersIdsToUnfollow: [String]) -> Single<Bool> {
        service.unfollowAll(userID: userID, usersIdsToUnfollow: usersIdsToUnfollow)
    }
}
