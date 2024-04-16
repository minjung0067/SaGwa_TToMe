import SwiftUI

struct ReceiveView: View {
    
    //let chat: Chat
    
    //@EnvironmentObject var viewModel: ChatsViewModel
    @StateObject var viewModel = ChatsViewModel()
    
    
    @State private var query = ""
    @State private var showCancelButton: Bool = true
    
    
    var body: some View {
        
        VStack {
            // Search view
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
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
            
            ZStack{
                GeometryReader { reader in
                    ScrollView {
                        getMessagesView(viewWidth: reader.size.width)
                    }
                    
                }
                
                //.resignKeyboardOnDragGesture()
                
                VStack{
                    Spacer()
                    Image("bubble")
                        .resizable()
                        .frame(width: 310, height: 45, alignment: .center)
                        .opacity(0.5)
                }
            }
            
            
            
        }
        
    }
    
    let columns = [GridItem(.flexible(minimum: 1))]
    
    func getMessagesView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(viewModel.getSortedFilteredChats(query: query)) { chat in
                VStack(spacing: 5) {
                    //요일
                    Text(chat.messages.last?.date.descriptiveString() ?? "")
                        .fontWeight(.regular)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.45, opacity: 0.5))
                        .frame(alignment: .center)
                        .font(.footnote)
                    
                    HStack(spacing: 10.0){
                        //프로필
                        VStack(){
                            Spacer()
                            Image(chat.person.imgString)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height:40, alignment: .center)
                                .clipShape(Circle())
                            
                        }
                        .padding(.all, 15)
                        HStack{
                            ZStack{
                                Text(chat.messages.last?.text ?? "")
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
                .padding(.all, 10)
                .padding(.bottom, 10)
            }
        }
    }
}



struct Receive_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReceiveView()
                .environment(\.colorScheme, .light)
            
            ReceiveView()
                .environment(\.colorScheme, .dark)
        }
    }
}

#Preview {
    ReceiveView()
}
