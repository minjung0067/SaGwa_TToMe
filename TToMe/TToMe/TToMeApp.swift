//
//  TToMeApp.swift
//  TToMe
//
//  Created by Minjung Lee on 4/13/24.
//

import SwiftUI



@main
struct TToMeApp: App {

  var body: some Scene {
    WindowGroup {
      NavigationView {
          SignUpView()
              .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
      }
    }
  }
}

