import SwiftUI

struct SendView: View {
    
    @EnvironmentObject var viewModel: JsonModel

    
    @State private var placeholder = "받는 사람 : 또나"
    @State private var text = ""
    @State private var isSent = false
    @State private var isActivate = false
    
    @State private var waitingText = "또나가 메세지를 확인하고 있어요."
    @FocusState private var isFocused
    
    
    
    var body: some View {
        
            VStack {
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "paperplane")
                
                        TextField("받는 사람 : 또나", text: $placeholder, onEditingChanged: { isEditing in
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.gray)
                            .disabled(true)
                        
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                }
                .padding(.horizontal)
                
                HStack{
                    ZStack{
                        if isSent {
                            HStack(alignment: .center){
                                Text("오늘의 메세지를 이미 전송했어요")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                    
                            }

                        }

                    }
                    .frame(width: 300 * 0.7, alignment: .trailing)
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Spacer()
                
                toolbarView()
            }
            .navigationBarTitle(Text("메세지"))
            //.resignKeyboardOnDragGesture()
            .navigationBarTitleDisplayMode(.large)
    }
    
    func toolbarView() -> some View {
        VStack {
            let height: CGFloat = 42
            HStack {
                TextField(waitingText, text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .focused($isFocused)
                    .disabled(isActivate)
                Button(action: sendMessage) {
                    Image("sendBtn")
                        .resizable()
                        .frame(width: height, height: height)
                        .opacity(text.isEmpty ? 0.4 : 1)
                    
                }
                .disabled(text.isEmpty)
            }
            .frame(height: height)
            
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thickMaterial)
    }
    
    func sendMessage(){
        print("sendMessage 클릭")
    
        guard !text.isEmpty else { return }
        viewModel.sendMessage(text)
        text = ""
        isSent.toggle()
        isActivate.toggle()
        waitingText = "또나가 메세지를 확인하고 있어요."
        
        
//        if let message = viewModel.sendMessage(text, in: chat) {
//            text = ""
//            messageIDToScroll = message.id
//        }
    }
}
