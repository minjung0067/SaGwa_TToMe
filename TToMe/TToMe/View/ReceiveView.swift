//
//  ReceiveView.swift
//
//  받은 채팅들이 쌓이는 화면
//
//  Created by Minjung Lee on 4/15/24.
//

import SwiftUI

struct ReceiveView: View {
    @EnvironmentObject var viewModel: JsonModel
    
    @State private var query = ""
    @State private var showCancelButton: Bool = true
    
    
    var body: some View {
        
        VStack {
            // Search view
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    // MARK: - 키워드 검색창
                    TextField("키워드로 검색하기", text: $query, onEditingChanged: { isEditing in
                    }, onCommit: {
                        print("onCommit")
                    }).foregroundColor(.primary)
                    
                    Button(action: {
                        self.query = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(query == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                
                // MARK: 달력 버튼 (구현 x)
                Button(action: {
                    print("달력 버튼 클릭")

                }) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .foregroundColor(Color(.gray))
            }
            .padding(.horizontal)
            
            // MARK: - 채팅 화면
            ZStack{
                GeometryReader { reader in
                    ScrollView {
                        ScrollViewReader { scrollReader in
                            // 채팅 json으로 부터 가져오는 부분
                            getMessagesView(viewWidth: reader.size.width)
                                .padding(.horizontal)
                                .onAppear {
//                                    if let messageId = JsonModel.msg.?.id {
//                                        scrollTo(messageID: messageId, anchor: .bottom, shouldAnimate: true, scrollReader:scrollReader)
//                                    }
                                }
                        }

                    }
                    
                }
                
            }
            
            
            
        }
        .navigationBarTitle(Text("또나"))
        
    }
    
    
    func scrollTo(messageID: UUID, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 1))]
    
    // MARK: - 메세지를 가져와서 뿌리는 함수
    func getMessagesView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(viewModel.getSortedFilteredChats(query: query), id: \.id) { chat in
                VStack(spacing: 5) {
                    // MARK: 요일
                    Text(chat.writtenAt.descriptiveString())
                        .fontWeight(.regular)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.45, opacity: 0.5))
                        .frame(alignment: .center)
                        .font(.footnote)
                    
                    HStack(spacing: 10.0){
                        // MARK: 프로필 화면
                        VStack(){
                            Spacer()
                            Image("profile")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height:40, alignment: .center)
                                .clipShape(Circle())
                        }
                        
                        // MARK: 메세지
                        HStack{
                            ZStack{
                                Text(chat.msg)
                                    .font(.system(size: 13))
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .foregroundColor(.white)
                                    .background(Color(red: 0.399, green: 0.415, blue: 0.999, opacity: 0.847))
                                    .cornerRadius(15)
                            }
                            .frame(width: viewWidth * 0.7, alignment: .leading)
                            .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                }
                .padding(.all, 5)
                .padding(.bottom, 10)
            }
        }
    }

}


//
//struct Receive_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ReceiveView()
//                .environment(\.colorScheme, .light)
//            
//            ReceiveView()
//                .environment(\.colorScheme, .dark)
//        }
//    }
//}

//#Preview {
//    ReceiveView()
//}
