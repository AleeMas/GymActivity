import SwiftUI
import Foundation

struct ImagePickerView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var user: User

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @ObservedObject var user: User

        init(presentationMode: Binding<PresentationMode>, user: ObservedObject <User>) {
            _presentationMode = presentationMode
            _user = user
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            // image = Image(uiImage: uiImage)
            user.setImg(setter: uiImage)
            user.setImage()
            user.setGotImage(setter:true)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }
    
    

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, user: _user)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePickerView>) {

    }
    
}


