//
//  loginController+handler.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 8/31/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//

import UIKit

extension loginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    func imageViewTouchHandler(_ sender: UITapGestureRecognizer){
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.allowsEditing = true
    present(imagepicker, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker:UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let orignalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
       selectedImageFromPicker = orignalImage
//            print(info)
           
            
    }
        if let selectedimage = selectedImageFromPicker {
            imageView.image = selectedimage
            imageView.setNeedsDisplay()
        }
    picker.dismiss(animated: true, completion: nil)
        
    }
}
