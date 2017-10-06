////
////  chatLogController.swift
////  FireBallProject
////
////  Created by Chaitanya Pandit on 9/18/17.
////  Copyright © 2017 Chaitanya Pandit. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//
//
//class chatLogController:UICollectionViewController, UITextViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
//
//    
//    
//    var myViewBottomContraint = NSLayoutConstraint()
//    var chatViewHeightContraint = NSLayoutConstraint()
//    var chatView = UIView()
//    let sendButton = UIButton()
//    let textField = UITextView()
//    var textFieldWidth: CGFloat = 0.0
//    var textFieldWidthConstant: CGFloat = 0
//    var previousRect: CGRect = CGRect.zero
//    var userInfo = Users()
//    var navBarView = UIView()
//    var navBarLable = UILabel()
//    var navBarImageView = UIImageView()
//    var userInfoFromViewController = InboxMessages()
//    let cellID = "messageCell"
//    var screenWidth = UIScreen.main.bounds.width
//    let screenHeight = UIScreen.main.bounds.height
//    var inboxMessageArray = [InboxMessages]()
//    var navBartoID:String?
//    var addImageButton = UIButton()
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView?.backgroundColor = UIColor.white
//        collectionView?.register(MessagesCollectionViewCell.self, forCellWithReuseIdentifier: "messageCell")
//        collectionView?.alwaysBounceVertical = true
//        
//       collectionView?.contentInset = UIEdgeInsetsMake(10, 0, 50, 0)
//        
//
//        addView()
//        hidekeyboard()
//   
//        createNavBarView()
//        
//        observerChatLog()
//        NotificationCenter.default.addObserver(self,
//        selector: #selector(chatLogController.keyboardWillShow(notification:)),
//        name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self,
//        selector: #selector(chatLogController.keyboardWillHide(notification:)),
//        name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        
//        
//        
//    }
//    
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//        NotificationCenter.default.removeObserver(self)
//        
//    }
//    
//    func observerChatLog(){
//        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
//            return
//        }
//        var id:String?
//        if userInfoFromViewController.fromID != nil {
//            
//            id = userInfoFromViewController.getID()
//            
//        }else{
//            id = userInfo.toID
//        }
//        
//        let userReference = FIRDatabase.database().reference().child("user-messages").child(uid).child(id!)
//        userReference.observe(FIRDataEventType.childAdded, with: { (snapshot) in
//            
//
////
//                 let messageID = snapshot.key
//                let messageRef = FIRDatabase.database().reference().child("messages").child(messageID)
//                            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                
//                                if let dictionary = snapshot.value as? [String: AnyObject] {
//                                let inboxmessage = InboxMessages()
//                                inboxmessage.fromID = dictionary["fromID"] as? String
//                                inboxmessage.text = dictionary["text"] as? String
//                                inboxmessage.toID = dictionary["toID"] as? String
//                                inboxmessage.messageImageUrl = dictionary["messageImageUrl"] as? String
//                                self.inboxMessageArray.append(inboxmessage)
//                                    DispatchQueue.main.async {
//                                         self.collectionView?.reloadData()
//                                        self.scrollToBottom()
//                                    }
//                
//                                }
//                
//                            }, withCancel: nil)
//                
//            }, withCancel: nil)
//        
//        
//        
//
//      //  }, withCancel: nil)
//
//    }
//    
//    
//    func createNavBarView(){
//        navBarView.frame = CGRect(x: 0, y: 0, width: 160, height: 40)
//        navBarLable.frame = CGRect(x: 55, y: 0, width: 105, height: 40)
//        navBarImageView.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
//        navBarImageView.layer.masksToBounds = true
//        navBarImageView.layer.cornerRadius = 16
//    
//        
//        if userInfo.name != nil {
//        navBarLable.text = userInfo.name
//            navBarImageView.cacheImageUsingUrlString(url: userInfo.profileImage!)
//         
//        }
//        
//        if userInfo.toID != nil {
//        navBartoID = userInfo.toID
//            
//        }
//        else
//        {
//        navBartoID = userInfoFromViewController.getID()
//        }
//            
//        FIRDatabase.database().reference().child("users").child(navBartoID!).observeSingleEvent(of: .value, with: {(snapshot) in
//                
//                if let dictionary = snapshot.value as? [String: AnyObject] {
//                self.navBarLable.text = dictionary["name"] as? String
//                    self.navBarImageView.cacheImageUsingUrlString(url: (dictionary["profileImage"] as? String)!)
//                }
//                
//                
//                
//            }, withCancel: nil)
//            
//            
//        
//                
//        navBarView.addSubview(navBarImageView)
//        navBarView.addSubview(navBarLable)
//        self.navigationItem.titleView = navBarView
//        
//        
//      
//    }
//    
// override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return inboxMessageArray.count
//
//    }
//    
//    
//
//    func scrollToBottom(){
//        let when = DispatchTime.now() + 0.9
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            
//            
//            let sections = self.collectionView?.numberOfSections
//            var items = self.collectionView?.numberOfItems(inSection: sections! - 1)
//            
//            
//            if items != nil && items! >= 0 && (items! - 1) > -1{
//                items = items! - 1
//                let index = IndexPath(row: items!, section: sections! - 1)
//                self.collectionView?.scrollToItem(at: index, at: UICollectionViewScrollPosition.bottom, animated: true)
//            }
//            
//            
//        }
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidLoad()
//        scrollToBottom()
//       
////
//    }
//    
//    
// override  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as! MessagesCollectionViewCell
//            let message = inboxMessageArray[indexPath.row]
//    var width:CGFloat = 0
//    var height:CGFloat = 0
//    
//    if let text = message.text{
//     width = estimatedHeightOfText(text: message.text!).width + 10
//        cell.widthAnchorSetter(width: width)
//    }
//    if message.fromID == FIRAuth.auth()?.currentUser?.uid{
//        cell.alignmentAnchorSetter(align: true)
//      //  print(message.getID())
//    }else{
//        
//        cell.alignmentAnchorSetter(align: false)
//    }
//    
//    if let text = message.text{
//            cell.messageTextView.text =  text
//    }
//    
//    if let text = message.messageImageUrl{
//        width = (screenWidth / 2)
//        cell.widthAnchorSetter(width: width )
//    }
//    
//    
//            
//    if let image = message.messageImageUrl{
//   // cell.messageImageView.cacheImageUsingUrlString(url: image)
//        //self.collectionView?.reloadData()
//    }
//    
//         return cell
//    }
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        self.collectionView?.collectionViewLayout.invalidateLayout()
//        screenWidth = size.width
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var height:CGFloat = 0
//        var width:CGFloat = 0
//        if let text = inboxMessageArray[indexPath.row].text {
//             height = estimatedHeightOfText(text: text).height + 30
//            width = estimatedHeightOfText(text: text).width + 30
//            }
//        
//        if let image = inboxMessageArray[indexPath.row].messageImageUrl{
//            return CGSize(width: Int(screenWidth / 2), height: Int((screenWidth / 2) + 20))
//            
//        }
//        return CGSize(width: width , height: height)
//    }
//    
//    private func estimatedHeightOfText(text:String) -> CGRect {
//        let size = CGSize(width: 200, height: CGFloat.greatestFiniteMagnitude)
//        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
//        return NSString(string: text).boundingRect(with: size, options: option, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)], context: nil)
//        
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 8.0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
//    }
//    
//    func addView(){
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        chatView.translatesAutoresizingMaskIntoConstraints = false
//        sendButton.translatesAutoresizingMaskIntoConstraints = false
//        addImageButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        addImageButton.backgroundColor = .clear
//        let addImage: UIImage = UIImage().resizeImage(image:  #imageLiteral(resourceName: "addImage"), targetSize: CGSize(width: 40, height: 30))
//        //addImage.resizeImage(image:  #imageLiteral(resourceName: "addImage"), targetSize: CGSize(width: 40, height: 30))
//        addImageButton.setBackgroundImage(addImage, for: UIControlState.normal)
//        addImageButton.addTarget(self, action: #selector(imageAddButton), for: UIControlEvents.touchDown)
//        
//        sendButton.backgroundColor = UIColor.white
//        sendButton.setTitle("Send", for: .normal)
//        sendButton.setTitleColor(UIColor.blue, for: .normal)
//        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        sendButton.addTarget(self, action: #selector(sendButtonTouchDown), for: .touchDown)
//        
//        
//        
//        
//        textField.backgroundColor = UIColor.white
//        textField.delegate = self
//        textField.text = "Enter message .... "
//        textField.textColor = UIColor.gray
//        
//        textField.returnKeyType = .done
//        
//        chatView.backgroundColor = UIColor(r: 206, g: 206, b: 206)
//        
//        
//        
//        chatView.addSubview(addImageButton)
//        chatView.addSubview(sendButton)
//        chatView.addSubview(textField)
//        
//        self.view.addSubview(chatView)
//        
//        
//        chatViewHeightContraint = NSLayoutConstraint(item: chatView, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 45)
//        
//        self.view.addConstraint(chatViewHeightContraint)
//        
//        
//        
//        self.view.addConstraint(NSLayoutConstraint(item: chatView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
//        
//        self.view.addConstraint(NSLayoutConstraint(item: chatView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
//        
//        myViewBottomContraint   = NSLayoutConstraint(item: chatView, attribute: .bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1 , constant: 0)
//        
//        self.view.addConstraint(myViewBottomContraint)
//        self.view.layoutIfNeeded()
//        
//        
//        
//        chatView.addConstraint(NSLayoutConstraint(item: addImageButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 40))
//     
//        chatView.addConstraint(NSLayoutConstraint(item: addImageButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 30))
//        
//        chatView.addConstraint(NSLayoutConstraint(item: addImageButton, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 6))
//        
//        chatView.addConstraint(NSLayoutConstraint(item: addImageButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
//        
//        
//        
//          chatView.addConstraint(NSLayoutConstraint(item: sendButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 60))
//        
//             chatView.addConstraint(NSLayoutConstraint(item: sendButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 39))
//        
//        chatView.addConstraint(NSLayoutConstraint(item: sendButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: .centerY, multiplier: 1, constant: 0))
//        
//        chatView.addConstraint(NSLayoutConstraint(item: sendButton, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -10))
//
//       
//        self.view.layoutIfNeeded()
//        chatView.layoutIfNeeded()
//        sendButton.layer.cornerRadius =  8
//        
//        
//        self.view.layoutIfNeeded()
//        chatView.layoutIfNeeded()
//        chatView.addConstraint(NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -6))
//
//      chatView.addConstraint(NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 6))
//
//        
//        chatView.addConstraint(NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: addImageButton, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 6))
//
//        chatView.addConstraint(NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: sendButton, attribute: NSLayoutAttribute.left, multiplier: 1, constant: -12))
//
//        chatView.layoutIfNeeded()
//        textFieldWidth = textField.layer.frame.width
//        
//        
//    }
//    
//    func imageAddButton(){
//        print("tap")
//        let imagepickercontroller = UIImagePickerController()
//        imagepickercontroller.delegate = self
//        imagepickercontroller.allowsEditing = true
//        present(imagepickercontroller, animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print("Finished picking")
//        var selectedImage:UIImage?
//        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage{
//            selectedImage = image
//        }else if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
//            selectedImage = image
//        }
//        uploadImage(messageImage: selectedImage!)
//        dismiss(animated: true, completion: nil)
//        
//    }
//    
//    private func uploadImage(messageImage:UIImage){
//        
//        let imageString = NSUUID().uuidString
//        let ref = FIRStorage.storage().reference().child("usermessage-images").child("\(imageString).jpg")
//        if let image = UIImageJPEGRepresentation(messageImage, 0.2) {
//            ref.put(image, metadata: nil, completion: { (metadata, error) in
//                if let err = error {
//                    print("There was error")
//                    return
//                }
//                    if let downloadURL = metadata?.downloadURL()?.absoluteString {
//                        
//                        self.sendImageAsMessage(messageImageUrl: downloadURL)
//                        
//                        
//                        
//                        
//                    }
//              
//            })
//        }
//        
//        
//    }
//    
//    private func sendImageAsMessage(messageImageUrl: String){
//        let sendMessage = FIRDatabase.database().reference().child("messages")
//        let childReference = sendMessage.childByAutoId()
//        var values = [String : String]()
//        var toID:String?
//        if  userInfo.toID != nil{
//                toID = self.userInfo.toID
//        } else{
//            toID = userInfoFromViewController.getID()
//            }
//            let fromID = FIRAuth.auth()!.currentUser!.uid
//            let timeStamp:String = String(NSDate().timeIntervalSince1970)
//            values = ["messageImageUrl": messageImageUrl, "toID": toID!,"fromID": fromID,"timeStamp": timeStamp]
//            childReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
//                if error != nil {
//                    return
//                }
//                let userMessageRef = FIRDatabase.database().reference().child("user-messages").child(fromID).child(toID!)
//                let messageID = childReference.key
//                userMessageRef.updateChildValues([messageID:1])
//                
//                let toUserMessageRef = FIRDatabase.database().reference().child("user-messages").child(toID!).child(fromID)
//                toUserMessageRef.updateChildValues([messageID:1])
//                
//            })
//        
//        
//    }
//    
//    
//    func sendButtonTouchDown(){
//        let sendMessage = FIRDatabase.database().reference().child("messages")
//        let childReference = sendMessage.childByAutoId()
//        var values = [String : String]()
//        if textField.text.isEmpty == false, let toID = userInfo.toID {
//            let fromID = FIRAuth.auth()!.currentUser!.uid
//            
//            
//            
//            let timeStamp:String = String(NSDate().timeIntervalSince1970)
//            values = ["text": textField.text, "toID": userInfo.toID!,"fromID": fromID,"timeStamp": timeStamp]
//            childReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
//                if error != nil {
//                    return
//                }
//                let userMessageRef = FIRDatabase.database().reference().child("user-messages").child(fromID).child(toID)
//                let messageID = childReference.key
//                userMessageRef.updateChildValues([messageID:1])
//                
//                let toUserMessageRef = FIRDatabase.database().reference().child("user-messages").child(toID).child(fromID)
//                toUserMessageRef.updateChildValues([messageID:1])
//                
//            })
//        }
//        
//        
//        if textField.text != nil, var toID = userInfoFromViewController.toID{
//            let fromID = FIRAuth.auth()?.currentUser?.uid
//            
//            if toID == fromID{
//                toID = userInfoFromViewController.fromID!
//            }
//            
//            let timeStamp:String = String(NSDate().timeIntervalSince1970)
//            values = ["text": textField.text, "toID": toID,"fromID": fromID!,"timeStamp": timeStamp]
//            childReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
//                if error != nil {
//                    return
//                }
//                let userMessageRef = FIRDatabase.database().reference().child("user-messages").child(fromID!).child(toID)
//                let messageID = childReference.key
//                userMessageRef.updateChildValues([messageID:1])
//                
//                let toUserMessageRef = FIRDatabase.database().reference().child("user-messages").child(toID).child(fromID!)
//                toUserMessageRef.updateChildValues([messageID:1])
//                
//            })
//        }
//        
//       
//            dismissThisKeyboard()
//            textField.text = "Enter message .... "
//        DispatchQueue.main.async {
//            self.collectionView?.reloadData()
//        }
//        
//        
//        
//
//    }
//    
//    func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            myViewBottomContraint.constant = -keyboardSize.height
//            UIView.animate(withDuration: 0.33, animations: {
//                self.view.layoutIfNeeded()
//                self.scrollToBottom()
//            })
//                    }
//    }
//    func keyboardWillHide(notification: NSNotification) {
//        if ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
//            myViewBottomContraint.constant = 0
//            UIView.animate(withDuration: 0.33, animations: {
//                self.view.layoutIfNeeded()
//                self.collectionView?.layoutIfNeeded()
//                
//            })
//            if textField.text == "" {
//                textField.text = "Enter message .... "
//                self.chatViewHeightContraint.constant = 45
//            }
//
//        }
//    }
//    
//   
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textField.text == "Enter message .... "{
//            textField.text = ""
//        }
//   
//
//    
//    }
//    func textViewDidChangeSelection(_ textView: UITextView) {
//       
//        
//                let pos = self.textField.endOfDocument
//                let currentRect = self.textField.caretRect(for: pos)
//                if self.previousRect != CGRect.zero {
//                    if currentRect.origin.y > self.previousRect.origin.y {
//                        self.chatViewHeightContraint.constant = self.chatViewHeightContraint.constant + 10
//                    }
//                }
//        if currentRect == CGRect.zero{
//            self.chatViewHeightContraint.constant = 45
//        }
//                self.previousRect = currentRect
//        
//    }
//    
//    
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        dismissThisKeyboard()
//        return true
//    }
//    
//}
//
//extension UICollectionViewController{
//    func hidekeyboard(){
//        let keyboardHide: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UICollectionViewController.dismissThisKeyboard))
//        view.addGestureRecognizer(keyboardHide)
//
//}
//    
//    func dismissThisKeyboard(){
//            view.endEditing(true)
//    }
//}

