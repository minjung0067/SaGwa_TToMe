//
//  TToMeApp.swift
//  TToMe
//
//  Created by Minjung Lee on 4/13/24.
//

import SwiftUI



@main
struct TToMeApp: App {
    // json 형태로 저장되는 데이터 - 1. userdata, 2. chatdata
    @StateObject var jsonModel = JsonModel()
    
    
    
    var body: some Scene {
        WindowGroup {
            /* userData 없다 -> 가입 위해 SignUpView로
                userData 있다 > 앱 실행 시 바로 메인으로 */
            NavigationStack {
                if jsonModel.userData.isEmpty {
                    SignUpView(isEditing: false)
                        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                        // 화면 탭 했을 때 키보드 자동으로 내리는 액션을 하위 뷰에서 사용할 수 있도록 최상단에 선언
                } else {
                    MainView()
                        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                }
            }
        }
        .environmentObject(jsonModel)
        // 자식 view에서 값 변경 시 부모에서도 모두 뷰가 업데이트
    }
}

