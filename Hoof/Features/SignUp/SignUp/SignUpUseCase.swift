//
//  SignUpUseCase.swift
//  SignUp
//
//  Created Sameh Mabrouk on 27/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol SignUpInteractable {
    func signUp(userName: String, email: String, password: String, gender: String, bio: String, favoritePosition: String, foot: String, preferedNumber: Int) -> Single<Bool>
}

class SignUpUseCase: SignUpInteractable {

    private let service: SignUpServicePerforming
    
    init(service: SignUpServicePerforming) {
        self.service = service
    }
    
    func signUp(userName: String, email: String, password: String, gender: String, bio: String, favoritePosition: String, foot: String, preferedNumber: Int) -> Single<Bool> {
        service.signUp(userName: userName, email: email, password: password, gender: gender, bio: bio, favoritePosition: favoritePosition, foot: foot, preferedNumber: preferedNumber)
    }
}
