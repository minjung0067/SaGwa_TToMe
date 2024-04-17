import SwiftUI

struct SendView: View {
    
    @EnvironmentObject var viewModel: JsonModel

    
    @State private var placeholder = "받는 사람 : 또나"
    @State private var text = ""
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
                TextField("오늘 하루는 어땠나요 ?", text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .focused($isFocused)
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
//        if let message = viewModel.sendMessage(text, in: chat) {
//            text = ""
//            messageIDToScroll = message.id
//        }
    }
}
