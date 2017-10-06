
//
//  ViewController.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 8/21/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase



class ViewController: UITableViewController,resetNavBar {
    
    
    var titleImageView = UIImageView()
    var myView = UIView()
    var titleLable = UILabel()
    var systemUID = ""
    var inboxMessage = [InboxMessages]()
    var messageDictionary = [String: InboxMessages]()
    var timer:Timer?
    var counter:Int = 0
   
    
    
    func resetNavigationTitleView(str: String) {
        
        setNavigationTitleViewDetails()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        getMessages()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handlelogout))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "something")
        createNavigationView()
        addRightBarButton()
        checkIfUserIsLoggedIn()
        self.tableView.register(MessageCell.self, forCellReuseIdentifier: "Inbox")
       

      
    }
    
   
    
    
    func getMessages(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        let ref = FIRDatabase.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
         //   let messageID = snapshot.key
            
            let userID = snapshot.key
                        print(snapshot)
                        print(snapshot.key)
                        FIRDatabase.database().reference().child("user-messages").child(uid).child(userID).observe(FIRDataEventType.childAdded, with: { (snapshot) in
                                 print(snapshot)
            
            let messageID = snapshot.key
            
            let messageRef = FIRDatabase.database().reference().child("messages").child(messageID)
            messageRef.observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let message = InboxMessages()
                    message.fromID = dictionary["fromID"]  as? String
                    message.text = dictionary["text"] as? String
                    message.toID = dictionary["toID"] as? String
                    message.timeStamp = dictionary["timeStamp"] as? String
                    //self.inboxMessage.append(message)
                    let toId = message.getID()
                    if toId != nil {
                        self.messageDictionary[toId] = message
                        self.inboxMessage = Array(self.messageDictionary.values)
                        self.inboxMessage.sort(by: { (message1, message2) -> Bool in
                            let sm1 = message1.timeStamp
                            let sm2 = message2.timeStamp
                            let m1: Double = (sm1! as NSString).doubleValue
                            let m2: Double = (sm2! as NSString).doubleValue
                            return m1 > m2
                        })
                    }
                    
                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.reloadTableDate), userInfo: nil, repeats: false)
                    //self.reloadTableDate()
                    
                }
            }, withCancel: nil)
            }, withCancel: nil)
        }, withCancel: nil)
    }

    func reloadTableDate(){
//        counter = counter + 1
////        print("reloadTableDate called\(counter)")
        self.tableView.reloadData()
    }
    
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Inbox", for: indexPath) as! MessageCell
        if self.inboxMessage.count != 0 {
        let message = self.inboxMessage[indexPath.row]

            let toID = message.getID()
            
            let ref = FIRDatabase.database().reference().child("users").child(toID)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
              
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    cell.friendsName.text = dictionary["name"] as? String
                    cell.avatarImageView.cacheImageUsingUrlString(url: dictionary["profileImage"] as! String)
                    cell.friendsEmail.text = message.text
                    cell.timeStampLabel.text = self.epochToLocal(epochTime: Double(message.timeStamp!)!)
                    
                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.reloadTableDate), userInfo: nil, repeats: false)
                    //self.reloadTableDate()
                    
                   
                    
                }
            })
            
        }
        return cell
    }
    
    func handleReload(){
        DispatchQueue.main.async {
            print("reload called in handleReload")
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageDictionary.count
    }
    
    
    
    
    func addRightBarButton(){
        let button: UIButton = UIButton(type: .custom)

        let writeimage = UIImage().resizeImage(image:#imageLiteral(resourceName: "writeMessageImage"), targetSize: CGSize(width: 30, height: 30))
            button.setImage(writeimage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let barButton = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(writeButtonAction), for: .touchDown)
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    func writeButtonAction(){
        
        handleNewMessage()
    }
    func handleNewMessage(){
        let newMessageController =  NewMessageController()
        navigationController?.pushViewController(newMessageController, animated: true)
        
        
    }
    
    func createNavigationView(){
        self.navigationController?.navigationItem.titleView = nil
        myView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        myView.contentMode = .center
         titleLable.frame = CGRect(x: 50, y: 0, width: 90, height: 30)
        titleLable.text  = "Unknown"
        titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        titleImageView.layer.cornerRadius = 16
        titleImageView.layer.masksToBounds = true
        titleImageView.image = #imageLiteral(resourceName: "defaultProfileImage")
        titleImageView.contentMode = .scaleAspectFit
        myView.addSubview(titleImageView)
        myView.addSubview(titleLable)
      
        self.navigationController?.navigationItem.titleView = myView
        if  (FIRAuth.auth()?.currentUser?.uid) != nil{
            systemUID = (FIRAuth.auth()?.currentUser?.uid)!
            setNavigationTitleViewDetails()
        }

        
    }
    
    
    
    func checkIfUserIsLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            let _loginVC = loginController()
            _loginVC.delegate = self
            present( _loginVC,animated: true, completion: nil)

        }else 
        if FIRAuth.auth()?.currentUser?.uid != nil{
          
            
                       self.dismiss(animated: true, completion: nil)
                    }else{
            let _loginVC = loginController()
            _loginVC.delegate = self
            present( _loginVC,animated: true, completion: nil)
           
        }
      
        
    }
    
   
    func setNavigationTitleViewDetails(){
        inboxMessage.removeAll()
        messageDictionary.removeAll()
        tableView.reloadData()
       getMessages()
        if FIRAuth.auth()?.currentUser?.uid == nil {
            let _loginVC = loginController()
            _loginVC.delegate = self
            present( _loginVC,animated: true, completion: nil)

            
        }
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let mytitle = dictionary["name"] as! String
                let profileimage = dictionary["profileImage"]
                self.titleLable.text = mytitle
                self.titleImageView.cacheImageUsingUrlString(url: profileimage as! String)
                self.navigationItem.titleView = self.myView
            }
            
        }, withCancel: nil)
    
      
    }
    
    func handlelogout(){
        do{
            try FIRAuth.auth()?.signOut()
            self.titleLable.text = ""
            self.titleImageView.image = #imageLiteral(resourceName: "defaultProfileImage")
            let _loginController = loginController()
            _loginController.delegate = self
            present(_loginController, animated: true,completion: nil)
            
        }catch let _{

        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let chatLog = chatLogController(collectionViewLayout: UICollectionViewFlowLayout())
//        chatLog.userInfoFromViewController = inboxMessage[indexPath.row]
//        self.navigationController?.pushViewController(chatLog, animated: true)

        let chatLog = ChatUIViewController()
        chatLog.userInfoFromViewController = inboxMessage[indexPath.row]
        self.navigationController?.pushViewController(chatLog, animated: true)
        
    }
    
    func epochToLocal(epochTime:Double)->String{
    
    let timeResult:Double = epochTime
    let date = NSDate(timeIntervalSince1970: timeResult)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
    let timeZone = TimeZone.autoupdatingCurrent.identifier as String
    dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.dateFormat = "HH:mm a"
    let localDate = dateFormatter.string(from: date as Date)
    return "\(localDate)"
    
    }
    
    
}

extension UIImage{
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
}

