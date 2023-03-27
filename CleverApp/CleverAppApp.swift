//
//  CleverAppApp.swift
//  CleverApp
//
//  Created by Jorge Lucena on 27/3/23.
//

import SwiftUI
import CleverImage

@main
struct CleverAppApp: App {

    let signInUseCase = RemoteSignIn(url: URL(string: "https://mobility.cleverlance.com/")!,
                                     client: URLSessionHTTPClient(session: .shared))
    var body: some Scene {
        WindowGroup {
            ContentView(signInUseCase: signInUseCase)
        }
    }
}
