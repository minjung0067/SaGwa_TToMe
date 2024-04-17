//
//  SignUpView.swift
//  TToMe
//
//  Created by Minjung Lee on 4/16/24.
//

import SwiftUI

struct SignUpView: View {

    @EnvironmentObject var jsonModel: JsonModel
    
    @State private var authPath = 0

    /* ... */

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
            
            Picker(selection: $authPath, label: Text("Authentication Path")) {
                Text("이름").tag(0)
                Text("메세지 타임").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 30)
            .padding(.top, 30)


            if authPath == 0 {
                NameView(/* ... */)
                    //.animation(.default)
                    .transition(.move(edge: .leading))
                    .padding()
                    .frame(height: 500)
            }
            if authPath == 1 {
                MessageTimeView(/* ... */)
                    //.animation(.default)
                    .transition(.move(edge: .trailing))
                    .padding()
                    .frame(height: 500)
            }

            Spacer()
        }
        .padding(.all, 10)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}



#Preview {
    SignUpView()
}

