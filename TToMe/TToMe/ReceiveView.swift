import SwiftUI

struct ReceiveView: View {
    let array = ["1","2"]
    @State private var searchText = ""
    @State private var showCancelButton: Bool = true
    
    var body: some View {
        
        VStack {
            // Search view
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("키워드로 검색하기", text: $searchText, onEditingChanged: { isEditing in
                    }, onCommit: {
                        print("onCommit")
                    }).foregroundColor(.primary)
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
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
                List {
                    ForEach(0 ..< 5) { i in
                        ChatRow(chat: Chat.sampleChat[i])
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("또나"))
                .navigationBarTitleDisplayMode(.large)
                .resignKeyboardOnDragGesture()
                
                VStack{
                    Spacer()
                    Image("bubble")
                        .resizable()
                        .frame(width: 320, height: 45, alignment: .center)
                }
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

// Update for iOS 15
// MARK: - UIApplication extension for resgning keyboard on pressing the cancel buttion of the search bar
extension UIApplication {
    
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

#Preview {
    ReceiveView()
}
