//
//  MessageCell.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 9/14/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    let avatarImageView = UIImageView()
    let friendsName = UILabel()
    let friendsEmail = UILabel()
    let timeStampLabel = UILabel()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        avatarImageView.image = #imageLiteral(resourceName: "defaultProfileImage")
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = UIColor.red
       
        avatarImageView.clipsToBounds = true
        
        timeStampLabel.text = ""
        timeStampLabel.font = UIFont.systemFont(ofSize: 12.0)
        timeStampLabel.textColor = UIColor.gray
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false

       
        friendsName.translatesAutoresizingMaskIntoConstraints = false



        friendsEmail.font  = UIFont.italicSystemFont(ofSize: 10.0)
       friendsEmail.translatesAutoresizingMaskIntoConstraints = false

        
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(friendsName)
        contentView.addSubview(friendsEmail)
        contentView.addSubview(timeStampLabel)
        
        self.contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 56))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 56))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 10))
        
        
        self.contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 20))
        
        
        
         self.contentView.layoutIfNeeded()
        self.contentView.addConstraint(NSLayoutConstraint(item: timeStampLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 70))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: timeStampLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 20))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: timeStampLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
        
        
        self.contentView.addConstraint(NSLayoutConstraint(item: timeStampLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        
         self.contentView.layoutIfNeeded()
        
        
        self.contentView.addConstraint(NSLayoutConstraint(item: friendsName, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: timeStampLabel, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 70))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: friendsName, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: avatarImageView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 20))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: friendsName, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 20))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: friendsName, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -10))
        
        self.contentView.layoutIfNeeded()
        

        self.contentView.addConstraint(NSLayoutConstraint(item: friendsEmail, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 100))
        
         self.contentView.addConstraint(NSLayoutConstraint(item: friendsEmail, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 20))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: friendsEmail, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: friendsName, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 5))
        
        
        self.contentView.addConstraint(NSLayoutConstraint(item: friendsEmail, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: avatarImageView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 20))
        
        
        
        
        
        
        
        self.contentView.layoutIfNeeded()
        
        
        
        
        
        
        avatarImageView.layer.cornerRadius = (avatarImageView.frame.width / 2 )
        


        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

}
