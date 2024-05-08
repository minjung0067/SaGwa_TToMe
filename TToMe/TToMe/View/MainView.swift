//
//  MainView.swift
//
//  또나 메인 화면
//
//  Created by Minjung Lee on 4/15/24.
//

import SwiftUI

struct MainView: View {
    @State private var isActive: Bool = false
    
    @EnvironmentObject var viewModel: JsonModel
    
    
    
    var title: some View{
        VStack{
            Text("또나")
                .font(.system(size: 31, weight: .black))
                .fontWeight(.heavy)
                .foregroundColor(Color(hue: 0.144, saturation: 0.979, brightness: 0.131))
            Text("이민펑키")
                .font(.body)
                .foregroundColor(Color(red: 0.792156862745098, green: 0.792156862745098, blue: 0.792156862745098))
                .multilineTextAlignment(.center)
            
        }
        
    }
    
    var buttonRow: some View{
        HStack {
            Button(action: {
                print("left pressed")
            }) {
                NavigationLink(destination: ReceiveView()) {
                    ZStack{
                        Image("leftpung")
                            .resizable()
                            .frame(width: 144, height: 87)
                        VStack(spacing: 5.0){
                            Image(systemName: "ellipsis.message.fill")
                                .resizable()
                                .foregroundColor(Color(red: 0.4, green: 0.41568627450980394, blue: 1.0))
                                .frame(width: 24, height: 24.0)
                            Text("채팅 확인하기")
                                .font(.system(size: 13))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.208, green: 0.208, blue: 0.0))
                        }
                        .padding(.leading, 10.0)
                    }
                    
                }
                
            }
            
            Button(action: {
                print("right pressed")
            }) {
                NavigationLink(destination: SendView()) {
                    ZStack{
                        Image("rightpung")
                            .resizable()
                            .frame(width: 144, height: 87)
                        //.renderingMode(.original)
                        VStack(spacing: 5.0){
                            Image(systemName: "plus.message.fill")
                                .resizable()
                                .foregroundColor(Color(red: 0.4, green: 0.41568627450980394, blue: 1.0))
                                .frame(width: 24, height: 24.0)
                                .rotationEffect(Angle(degrees: 0))
                            Text("메세지 보내기")
                                .font(.system(size: 13))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.208, green: 0.208, blue: 0.0))
                        }
                        .padding(.trailing, 10.0)
                    }
                }
            }
        }
        .frame(width: 316, height: 60)
    }
    
    var content: some View{
        HStack(spacing: 20.0){
            VStack(spacing: 20.0){
                Text("메세지 타임")
                Text("최근 메세지")
            }
            .font(.system(size: 14))
            .fontWeight(.bold)
            .foregroundColor(Color(red: 0.208, green: 0.208, blue: 0.0))
            VStack(alignment: .leading, spacing: 20.0){
                HStack{
                    Text("매일 7시 00분")
                        .multilineTextAlignment(.leading)
                    NavigationLink(destination: SignUpView(isEditing: false)
                        .navigationBarBackButtonHidden(false))
                    {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                    
                }
                .foregroundColor(Color(hue: 0.767, saturation: 0.0, brightness: 0.523))
                
                Text(viewModel.chatData.last?.msg ?? "")
                    .foregroundColor(Color(red: 0.399, green: 0.415, blue: 0.999, opacity: 0.847))
            }
            .font(.system(size: 14))
            .frame(alignment: .topLeading)
        }
        .frame(alignment: .leading)
        .font(.subheadline)
    }
    
    
    
    var coverImage: some View{
        Image("profileimg")
            .resizable()
            .frame(width: 393, height: 568, alignment: .center)
    }
    
    var alertImage: some View{
        Button(action: {
            print("right pressed")
        }) {
                Image(systemName: "bell")
                    .resizable()
                    .foregroundColor(Color(red: 238, green: 238, blue:255))
                    .frame(width: 23, height: 25, alignment: .center)
                    .padding(.top, 120)

        }
                
    }
    
    // MARK: - user 구조체
    var card: some View{
        RoundedRectangle(cornerRadius: 30)
            .fill(.white)
            .overlay{
                VStack{
                    title
                    buttonRow
                        .padding(.all, 26)
                    content
                        .padding(.top, 20)
                }
                .padding(30)
            }
    }
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            ZStack{
                GeometryReader{ proxy in
                    coverImage
                        .ignoresSafeArea()
                    
                }
                
                VStack{
                    HStack(alignment: .top, spacing: 0){
                        Spacer()
                            .frame(width: 300)
                        alertImage
                    }
                    .position(x: 190, y: -30)
                    .frame(width: 393, height: 25, alignment: .top)
                    
                    Spacer()
                }

                
//                GeometryReader{ proxy in
                    VStack(spacing: 0){
                        Spacer()
                        card
                            .frame(height: 340)
                    }
  //              }
                

            }
        }
    }
}


#Preview {
    MainView()
}
