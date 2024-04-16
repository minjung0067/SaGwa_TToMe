//
//  SignUpView.swift
//  TToMe
//
//  Created by Minjung Lee on 4/16/24.
//

import SwiftUI


struct SignUpView: View {
    @State private var tab = 0
    @State var index = 0
    @State private var image = UIImage()
    @State private var isPhotoPickerPresented = false
    
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
            HStack {
                Text("또나가 당신을 어떻게 불러주길 바라나요?")
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            
            Spacer()
                .frame(height: 30)
            
            HStack{
                Picker(selection: $tab, label: Text("")) {
                    Text("이름").tag(0)
                    Text("메세지 타임").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
            }
            .padding(.all, 10)
            .padding(.horizontal, 20.0)

            VStack {
                Image(uiImage: self.image)
                    .resizable()
                    .cornerRadius(100)
                    .frame(width: 200, height: 200)
                    .background(Color.white)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                Text("Pick a photo")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .onTapGesture {
                        isPhotoPickerPresented.toggle()
                    }
            }
            .sheet(isPresented: $isPhotoPickerPresented) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .padding(.all, 10)
    }
}

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

#Preview {
    SignUpView()
}
