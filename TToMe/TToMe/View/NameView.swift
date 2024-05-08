//
//  NameView.swift
//
//  이름을 설정하는 화면, SignUpView의 왼쪽 selected 화면
//
//  Created by Minjung Lee on 4/16/24.
//

import SwiftUI
import PhotosUI


struct NameView: View {
    
    @State private var tab = 0
    @State var index = 0
    @State private var image = UIImage()
    @State private var isPhotoPickerPresented = false
    @Binding var isPickerDisable: Bool
    
    let height: CGFloat = 42
    
    @EnvironmentObject var viewModel: JsonModel
    
    @State private var placeholder = "네 이름을 알려줘!"
    @Binding var name: String
    @Binding var authPath: Int
    
    //@Binding var checked: Bool
    
    @FocusState private var isFocused
    
    var body: some View {
        
        VStack(spacing: 20) {
            ZStack {
                //Image(uiImage: self.image)
                Image("bigprofile")
                    .resizable()
                    .cornerRadius(100)
                    .frame(width: 230, height: 230)
                    .background(Color.white)
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipShape(Circle())


            }
            .padding(.bottom, 20.0)
            .frame(height: 250)
            
            ZStack {
                TextField("이름", text: $name)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .frame(width: 280, height: height+7, alignment: .center)
                    .font(.system(size: 16))
                    .background(Color(hue: 0.663, saturation: 0.538, brightness: 0.928, opacity: 0.365))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .focused($isFocused)
                
                HStack(alignment: .center){
                    Spacer()
                    Button(action: saveName) {
                        Image("nextbtn")
                            .resizable()
                            .frame(width: height, height: height)
                            .opacity(name.isEmpty ? 0.4 : 1)
                        
                    }
                    .padding(.all, 4)
                    .disabled(name.isEmpty)
                }

            }
            .padding(.all, 70.0)
            .frame(height: height)
            Spacer()

        }
        .navigationBarTitleDisplayMode(.large)
        .padding(.all, 20)
        

    }
    // MARK: - 이름이 작성되면 메세지타임 picker로의 이동이 활성화
    func saveName() {
        print("savename")
        authPath = 1
        guard !name.isEmpty else { return }
        isPickerDisable = false
        //viewModel.sendMessage(name)
    }
}

// MARK: - 더 이상 안 쓰일 imagePicker
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


// MARK: - 터치로 키보드 내리기 
extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
#Preview {
    NameView(isPickerDisable: .constant(true), name: .constant("펑키"), authPath: .constant(0))
}

