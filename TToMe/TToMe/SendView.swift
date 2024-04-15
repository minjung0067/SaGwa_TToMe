import SwiftUI

struct SendView: View {
    let array = ["1","2"]
    @State private var searchText = ""
    
    var body: some View {
        
            VStack {
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "paperplane")
                        
                        TextField("받는 사람 : 또나", text: $searchText, onEditingChanged: { isEditing in
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)
                            .disabled(true)
                        
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                }
                .padding(.horizontal)
                
                Spacer()
                
//                ZStack()
//                    .frame(width: 200, height: 500, alignment: .center)
//                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            .navigationBarTitle(Text("메세지"))
            .resignKeyboardOnDragGesture()
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SendView()
}
