//
//  ContentView.swift
//  RecReqSwiftUI
//
//  Created by Persson Group on 12/26/22.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?
    @Binding var showSecondView: Bool
    init(isShown: Binding<Bool>, image: Binding<Image?>, secondView: Binding<Bool>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
      _showSecondView = secondView
  }
  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     imageInCoordinator = Image(uiImage: unwrapImage)
     isCoordinatorShown = false
      showSecondView = true
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}

struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var secondView: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, secondView: $secondView)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct SecondView: View {
    var body: some View{
        Text("hi")
    }
}

struct ContentView: View {
    
    @State var image: Image? = nil
    @State var showCaptureImageView = false
    @State var showSecondView = false
    var body: some View {
        NavigationView{
            VStack{
            Button(action: {
              self.showCaptureImageView.toggle()
            }) {
              Text("Choose photos")
            }


          if (showCaptureImageView) {
              CaptureImageView(isShown: $showCaptureImageView, image: $image, secondView: $showSecondView)
          }
            NavigationLink(destination: Text("GOT IT BABY LEGOOOOO"), isActive: $showSecondView){EmptyView()}
        }
        }
      }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

