//
//  TToMeApp.swift
//  TToMe
//
//  Created by Minjung Lee on 4/13/24.
//

import SwiftUI



@main
struct TToMeApp: App {
    @StateObject var jsonModel = JsonModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if jsonModel.userData.isEmpty {
                    SignUpView(isEditing: false)
                        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                } else {
                    MainView()
                        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                }
            }
        }
        .environmentObject(jsonModel)
    }
}

