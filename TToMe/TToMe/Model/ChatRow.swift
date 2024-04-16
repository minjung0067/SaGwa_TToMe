////
////  ChatRow.swift
////  TToMe
////
////  Created by Minjung Lee on 4/15/24.
////
//
//import SwiftUI
//
//struct ChatRow: View {
//    
//    let chat: Chat
//    
//    var body: some View {
//        
//        VStack(spacing: 5) {
//            //요일
//            Text(chat.messages.last?.date.descriptiveString() ?? "")
//                .fontWeight(.regular)
//                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.45, opacity: 0.5))
//                .frame(alignment: .center)
//                .font(.footnote)
//            
//            HStack(spacing: 10.0){
//                //프로필
//                VStack(){
//                    Spacer()
//                    Image(chat.person.imgString)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 40, height:40, alignment: .center)
//                        .clipShape(Circle())
//                    
//                }
//                .padding(.bottom, 5)
//                HStack{
//                    ZStack{
//                            Text(chat.messages.last?.text ?? "")
//                                .font(.system(size: 13))
//                                .foregroundColor(.white)
//                                //.lineLimit(2)
//                                .frame(alignment: .top)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    
//                    .padding(.vertical, 12)
//                    .padding(.horizontal)
//                    .background(Color(red: 0.399, green: 0.415, blue: 0.999, opacity: 0.747))
//                    .cornerRadius(33)
//                    .padding(.all, 13.0)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//                
//            }
//        }
//    }
//}
//
//struct ChatRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatRow(chat: Chat.sampleChat[0])
//    }
//}
