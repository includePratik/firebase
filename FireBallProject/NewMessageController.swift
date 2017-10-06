

//
//  NewMessageControllerTableViewController.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 8/29/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    var users = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationItem()
        self.tableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        getFirUser()
    }
    
    func addNavigationItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target:
            self, action: #selector(dismissWriteMessageView))
    }
    
    func dismissWriteMessageView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func getFirUser(){
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = Users()
                user.name =  dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                user.profileImage = dictionary["profileImage"] as? String
                user.toID = snapshot.key 
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }, withCancel: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let chatLog = chatLogController(collectionViewLayout: UICollectionViewFlowLayout())
//        chatLog.userInfo = users[indexPath.row]
//        self.navigationController?.pushViewController(chatLog, animated: true)
        
        let chatLog = ChatUIViewController()
       chatLog.userInfo = users[indexPath.row]
        self.navigationController?.pushViewController(chatLog, animated: true)
       
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell

        let user = self.users[indexPath.row]
        cell.friendsName.text = user.name
        cell.friendsEmail.text = user.email
        
        cell.avatarImageView.cacheImageUsingUrlString(url: user.profileImage!)
        
    return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
