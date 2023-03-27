//
//  CleverImageViewController.swift
//  CleverImageiOS
//
//  Created by Jorge Lucena on 27/3/23.
//

import UIKit
import CleverImage

public final class CleverImageViewController: UIViewController {

    let signIn: SignInUseCase

    public init(signIn: SignInUseCase) {
        self.signIn = signIn
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
