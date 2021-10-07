//
//  ImageUploader.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 06/10/21.
//

import Foundation
import UIKit
import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(_ image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "Profile images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("error", error.localizedDescription)
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    
}
