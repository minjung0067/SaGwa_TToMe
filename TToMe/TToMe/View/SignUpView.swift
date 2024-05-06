//
//  SignUpView.swift
//  TToMe
//
//  Created by Minjung Lee on 4/16/24.
//

import SwiftUI

struct SignUpView: View {

    @EnvironmentObject var jsonModel: JsonModel
    
    // name or msg picker
    @State private var authPath = 0
    
    @State private var name: String = ""
    @State private var messageTime: Date = Date.now
    @State private var isPickerDisable = true
    
    // isEditing 메인화면에서 수정하는 상황일 때 true
    var isEditing: Bool
    
    init(isEditing: Bool) {
        self.isEditing = isEditing
    }

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            HStack {
                Text("반가워요")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            HStack {
                Text("또나에게 당신에 대해 알려주세요 !")
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            
            
            // Mark: picker
            Picker(selection: $authPath, label: Text("name or msg time")) {
                Text("이름").tag(0)
                Text("메세지 타임").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 30)
            .padding(.top, 30)
            .disabled(isPickerDisable)


            if authPath == 0 {
                NameView(isPickerDisable: $isPickerDisable, name: $name,
                         authPath: $authPath)
                    //.animation(.default)
                    .transition(.move(edge: .leading))
                    .padding()
                    .frame(height: 500)
            } else if authPath == 1 {
                MessageTimeView(name: $name, messageTime: $messageTime)
                    //.animation(.default)
                    .transition(.move(edge: .trailing))
                    .padding()
                    .frame(height: 500)
            }

            if isEditing {
                
            }
            Spacer()
        }
        .padding(.all, 10)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}



#Preview {
    SignUpView(isEditing: false)
}

