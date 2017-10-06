//
//  ChatUIViewController.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 10/4/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//

import UIKit
import Firebase

class ChatUIViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var myViewBottomContraint = NSLayoutConstraint()
    var chatViewHeightContraint = NSLayoutConstraint()
    let sendButton = UIButton()
    let textField = UITextView()
    var textFieldWidth: CGFloat = 0.0
    var textFieldWidthConstant: CGFloat = 0
    var previousRect: CGRect = CGRect.zero
    var userInfo = Users()
    var navBarView = UIView()
    var navBarLable = UILabel()
    var navBarImageView = UIImageView()
    var userInfoFromViewController = InboxMessages()
    let cellID = "messageCell"
    var screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var inboxMessageArray = [InboxMessages]()
    var navBartoID:String?
    var addImageButton = UIButton()
    var tabelViewHeightConstraint = NSLayoutConstraint()
    
    var chatView:UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .blue
        return myView
        }()
    var chatTableView:UITableView = {
   let myTableView = UITableView()
        myTableView.backgroundColor = .white
        myTableView.separatorStyle = .none
        myTableView.translatesAutoresizingMaskIntoConstraints = false
   return myTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createNavBarView()
        observerChatLog()
                chatTableView.delegate = self
                chatTableView.dataSource = self
         chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
//        chatTableView.frame = CGRect(x: 0, y: 0, width: CGFloat(view.frame.width), height: screenHeight - 50)
        self.view.addSubview(chatTableView)
        addView()
        self.view.layoutIfNeeded()
        
        self.view.addConstraint(NSLayoutConstraint(item: chatTableView, attribute: .bottom, relatedBy: .equal, toItem: chatView, attribute: .top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: chatTableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: chatTableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: chatTableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
        
        
                hidekeyboard()
        
    NotificationCenter.default.addObserver(self,selector: #selector(ChatUIViewController.keyboardWillShow(notification:)),
                name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self,selector: #selector(ChatUIViewController.keyboardWillHide(notification:)),
                name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    
    }
    
    
    
    func keyboardWillShow(notification: NSNotification) {
                if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    myViewBottomContraint.constant = -keyboardSize.height
                    UIView.animate(withDuration: 0.33, animations: {
                        self.chatTableView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: self.screenHeight - keyboardSize.height - 50, right: 5)
                        self.view.layoutIfNeeded()
                      
                    })
                            }
            }
            func keyboardWillHide(notification: NSNotification) {
                if ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                    myViewBottomContraint.constant = 0
                    UIView.animate(withDuration: 0.33, animations: {
                        self.view.layoutIfNeeded()
                        self.chatTableView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: self.screenHeight - 50, right: 5)
                        
        
                    })
                    if textField.text == "" {
                        textField.text = "Enter message .... "
                        self.chatViewHeightContraint.constant = 45
                    }
        
                }
            }
    
    
    func createChatMessageBox(){
        
    }
    
    func createNavBarView(){
        navBarView.frame = CGRect(x: 0, y: 0, width: 160, height: 40)
        navBarLable.frame = CGRect(x: 55, y: 0, width: 105, height: 40)
        navBarImageView.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        navBarImageView.layer.masksToBounds = true
        navBarImageView.layer.cornerRadius = 16
        
        
        if userInfo.name != nil {
            navBarLable.text = userInfo.name
            navBarImageView.cacheImageUsingUrlString(url: userInfo.profileImage!)
            
        }
        
        if userInfo.toID != nil {
            navBartoID = userInfo.toID
            
        }
        else
        {
            navBartoID = userInfoFromViewController.getID()
        }
        
        FIRDatabase.database().reference().child("users").child(navBartoID!).observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.navBarLable.text = dictionary["name"] as? String
                self.navBarImageView.cacheImageUsingUrlString(url: (dictionary["profileImage"] as? String)!)
            }
            
            
            
        }, withCancel: nil)
        
        
        
        
        navBarView.addSubview(navBarImageView)
        navBarView.addSubview(navBarLable)
        self.navigationItem.titleView = navBarView
        
        
        
    }
    func scrollToBottom(){
    let delay = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            let sections = self.chatTableView.numberOfSections - 1
            let numberofrows = self.chatTableView.numberOfRows(inSection: sections) - 1
            
            if numberofrows >= 0 && sections >= 0
            {
                self.chatTableView.scrollToRow(at: IndexPath(row: numberofrows, section: sections), at: UITableViewScrollPosition.bottom, animated: true)
                //self.view.layoutIfNeeded()
            }
            
        })
        
        
    }
    
    
    func observerChatLog(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        var id:String?
        if userInfoFromViewController.fromID != nil {
            
            id = userInfoFromViewController.getID()
            
        }else{
            id = userInfo.toID
        }
        
        let userReference = FIRDatabase.database().reference().child("user-messages").child(uid).child(id!)
        userReference.observe(FIRDataEventType.childAdded, with: { (snapshot) in
           
            let messageID = snapshot.key
            let messageRef = FIRDatabase.database().reference().child("messages").child(messageID)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let inboxmessage = InboxMessages()
                    inboxmessage.fromID = dictionary["fromID"] as? String
                    inboxmessage.text = dictionary["text"] as? String
                    inboxmessage.toID = dictionary["toID"] as? String
                    inboxmessage.messageImageUrl = dictionary["messageImageUrl"] as? String
                    self.inboxMessageArray.append(inboxmessage)
                    DispatchQueue.main.async {
                        self.chatTableView.reloadData()
                        self.scrollToBottom()
                    }
                    
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
   
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxMessageArray.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ChatTableViewCell
        let message = inboxMessageArray[indexPath.row]
        if message.text != nil
        {cell?.myTitleLable.text = message.text}
        if message.fromID == FIRAuth.auth()?.currentUser?.uid
        {cell?.setViewAnchor(align: true)}
        else {cell?.setViewAnchor(align: false)}
        
        

        if  let imgURL = message.messageImageUrl{
                let wid = (cell?.contentView.frame.width)! / 2
            cell?.seturlView()
            let delay = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            let tempImageView = UIImageView()
                tempImageView.image = #imageLiteral(resourceName: "imageDownloading")
                
            tempImageView.cacheImageUsingUrlString(url: imgURL)
            
                var img = tempImageView.image

                img = UIImage().resizeImage(image: img!, targetSize: CGSize(width: wid, height: wid))
                cell?.myimageView.image = img
            })
                let image = UIImage().resizeImage(image: #imageLiteral(resourceName: "imageDownloading"), targetSize: CGSize(width: wid, height: wid))
            //cell?.myimageView.cacheImageUsingUrlString(url: message.messageImageUrl!)
            cell?.myimageView.image = image
            
            
            

            return cell!
        }

        if  (cell?.myTitleLable.intrinsicContentSize.width) != nil {
            var width = (cell?.myTitleLable.intrinsicContentSize.width)! + 10
            if width > (cell?.contentView.frame.width)! {
                width = (cell?.contentView.frame.width)!
            }
        cell?.setViewWidth(width: width)
        }
        
        
       
        return cell!
    }
    
    
   func addView() {
    textField.translatesAutoresizingMaskIntoConstraints = false
    chatView.translatesAutoresizingMaskIntoConstraints = false
    sendButton.translatesAutoresizingMaskIntoConstraints = false
    addImageButton.translatesAutoresizingMaskIntoConstraints = false
    
    
    addImageButton.backgroundColor = .clear
    let addImage: UIImage = UIImage().resizeImage(image:  #imageLiteral(resourceName: "addImage"), targetSize: CGSize(width: 40, height: 30))
    //addImage.resizeImage(image:  #imageLiteral(resourceName: "addImage"), targetSize: CGSize(width: 40, height: 30))
    addImageButton.setBackgroundImage(addImage, for: UIControlState.normal)
    addImageButton.addTarget(self, action: #selector(imageAddButton), for: UIControlEvents.touchDown)
    
    sendButton.backgroundColor = UIColor.white
    sendButton.setTitle("Send", for: .normal)
    sendButton.setTitleColor(UIColor.blue, for: .normal)
    sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    sendButton.addTarget(self, action: #selector(sendButtonTouchDown), for: .touchDown)
    
    
    
    
    textField.backgroundColor = UIColor.white
    textField.delegate = self
    textField.text = "Enter message .... "
    textField.textColor = UIColor.gray
    
    textField.returnKeyType = .done
    
    chatView.backgroundColor = UIColor(r: 206, g: 206, b: 206)
    
    
    
    chatView.addSubview(addImageButton)
    chatView.addSubview(sendButton)
    chatView.addSubview(textField)
    
    self.view.addSubview(chatView)
    
    
    chatViewHeightContraint = NSLayoutConstraint(item: chatView, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 45)
    
    self.view.addConstraint(chatViewHeightContraint)
    
    
    
    self.view.addConstraint(NSLayoutConstraint(item: chatView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
    
    self.view.addConstraint(NSLayoutConstraint(item: chatView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
    
    myViewBottomContraint   = NSLayoutConstraint(item: chatView, attribute: .bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1 , constant: 0)
    
    self.view.addConstraint(myViewBottomContraint)
    self.view.layoutIfNeeded()
    
    
    
    chatView.addConstraint(NSLayoutConstraint(item: addImageButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 40))
    
    chatView.addConstraint(NSLayoutConstraint(item: addImageButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 30))
    
    chatView.addConstraint(NSLayoutConstraint(item: addImageButton, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 6))
    
    chatView.addConstraint(NSLayoutConstraint(item: addImageButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
    
    
    
    chatView.addConstraint(NSLayoutConstraint(item: sendButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 60))
    
    chatView.addConstraint(NSLayoutConstraint(item: sendButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 39))
    
    chatView.addConstraint(NSLayoutConstraint(item: sendButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: .centerY, multiplier: 1, constant: 0))
    
    chatView.addConstraint(NSLayoutConstraint(item: sendButton, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -10))
    
    
    self.view.layoutIfNeeded()
    chatView.layoutIfNeeded()
    sendButton.layer.cornerRadius =  8
    
    
    self.view.layoutIfNeeded()
    chatView.layoutIfNeeded()
    chatView.addConstraint(NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -6))
    
    chatView.addConstraint(NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: chatView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 6))
    
    
    chatView.addConstraint(NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: addImageButton, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 6))
    
    chatView.addConstraint(NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: sendButton, attribute: NSLayoutAttribute.left, multiplier: 1, constant: -12))
    
    chatView.layoutIfNeeded()
    textFieldWidth = textField.layer.frame.width
    
    
    }
    
    func sendButtonTouchDown(){
        let sendMessage = FIRDatabase.database().reference().child("messages")
        let childReference = sendMessage.childByAutoId()
        var values = [String : String]()
        if textField.text.isEmpty == false, let toID = userInfo.toID {
            let fromID = FIRAuth.auth()!.currentUser!.uid
            
            
            
            let timeStamp:String = String(NSDate().timeIntervalSince1970)
            values = ["text": textField.text, "toID": userInfo.toID!,"fromID": fromID,"timeStamp": timeStamp]
            childReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    return
                }
                let userMessageRef = FIRDatabase.database().reference().child("user-messages").child(fromID).child(toID)
                let messageID = childReference.key
                userMessageRef.updateChildValues([messageID:1])
                
                let toUserMessageRef = FIRDatabase.database().reference().child("user-messages").child(toID).child(fromID)
                toUserMessageRef.updateChildValues([messageID:1])
                
            })
        }
        
        
        if textField.text != nil, var toID = userInfoFromViewController.toID{
            let fromID = FIRAuth.auth()?.currentUser?.uid
            
            if toID == fromID{
                toID = userInfoFromViewController.fromID!
            }
            
            let timeStamp:String = String(NSDate().timeIntervalSince1970)
            values = ["text": textField.text, "toID": toID,"fromID": fromID!,"timeStamp": timeStamp]
            childReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    return
                }
                let userMessageRef = FIRDatabase.database().reference().child("user-messages").child(fromID!).child(toID)
                let messageID = childReference.key
                userMessageRef.updateChildValues([messageID:1])
                
                let toUserMessageRef = FIRDatabase.database().reference().child("user-messages").child(toID).child(fromID!)
                toUserMessageRef.updateChildValues([messageID:1])
                
            })
        }
        
        
        dismissThisKeyboard()
        textField.text = "Enter message .... "
        DispatchQueue.main.async {
            
        }
        
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Finished picking")
        var selectedImage:UIImage?
        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImage = image
        }else if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = image
        }
        uploadImage(messageImage: selectedImage!)
        dismiss(animated: true, completion: nil)
        
    }
    private func uploadImage(messageImage:UIImage){
        
        let imageString = NSUUID().uuidString
        let ref = FIRStorage.storage().reference().child("usermessage-images").child("\(imageString).jpg")
        if let image = UIImageJPEGRepresentation(messageImage, 0.2) {
            ref.put(image, metadata: nil, completion: { (metadata, error) in
                if let err = error {
                    print("There was error")
                    return
                }
                if let downloadURL = metadata?.downloadURL()?.absoluteString {
                    
                    self.sendImageAsMessage(messageImageUrl: downloadURL)
                    
                    
                    
                    
                }
                
            })
        }
        
        
    }
    
    private func sendImageAsMessage(messageImageUrl: String){
        let sendMessage = FIRDatabase.database().reference().child("messages")
        let childReference = sendMessage.childByAutoId()
        var values = [String : String]()
        var toID:String?
        if  userInfo.toID != nil{
            toID = self.userInfo.toID
        } else{
            toID = userInfoFromViewController.getID()
        }
        let fromID = FIRAuth.auth()!.currentUser!.uid
        let timeStamp:String = String(NSDate().timeIntervalSince1970)
        values = ["messageImageUrl": messageImageUrl, "toID": toID!,"fromID": fromID,"timeStamp": timeStamp]
        childReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                return
            }
            let userMessageRef = FIRDatabase.database().reference().child("user-messages").child(fromID).child(toID!)
            let messageID = childReference.key
            userMessageRef.updateChildValues([messageID:1])
            
            let toUserMessageRef = FIRDatabase.database().reference().child("user-messages").child(toID!).child(fromID)
            toUserMessageRef.updateChildValues([messageID:1])
            
        })
        
        
    }
    
    
    func imageAddButton(){
        print("tap")
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        imagepickercontroller.allowsEditing = true
        present(imagepickercontroller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
}

extension UIViewController{
    func hidekeyboard(){
        let keyboardHide: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissThisKeyboard))
        view.addGestureRecognizer(keyboardHide)
        
    }
    
    func dismissThisKeyboard(){
        view.endEditing(true)
    }
}

