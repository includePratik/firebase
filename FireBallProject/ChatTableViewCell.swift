//
//  ChatTableViewCell.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 10/4/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var imageViewLeftRightConstraint = NSLayoutConstraint()
    var imageViewWidthAnchor = NSLayoutConstraint()
    var myimageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.clipsToBounds = true
        return img
    }()
    let myView = UIView()
    var myViewWidth = NSLayoutConstraint()
    var lableLeft =  NSLayoutConstraint()
    var lableRight =  NSLayoutConstraint()
    var lableTop =  NSLayoutConstraint()
    var LableBottom =  NSLayoutConstraint()
    var myViewAnchor = NSLayoutConstraint()
    
    var myTitleLable:UILabel  = {
        let titlelabel = UILabel()
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.numberOfLines = 0
        titlelabel.lineBreakMode = .byWordWrapping
        titlelabel.backgroundColor = .clear
        titlelabel.textColor = .black
        titlelabel.textAlignment = .right
        titlelabel.font = UIFont.systemFont(ofSize: 18)
        return titlelabel
    }()
    

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        myView.backgroundColor = UIColor.blue
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.layer.masksToBounds = true
        myView.clipsToBounds = true
        self.contentView.addSubview(myView)
        myView.addSubview(myTitleLable)
        myView.addSubview(myimageView)
        
        myViewWidth = NSLayoutConstraint(item: myView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        contentView.addConstraint(myViewWidth)
        
        myViewAnchor = NSLayoutConstraint(item: myView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -7)
        contentView.addConstraint(myViewAnchor)
        contentView.addConstraint(NSLayoutConstraint(item: myView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8))
        contentView.addConstraint(NSLayoutConstraint(item: myView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -8))
        
        setLableConstraints()
        
        myView.layer.cornerRadius = 16
        myimageView.layer.cornerRadius = 16
        self.contentView.layoutIfNeeded()
    }
    func updateLayout(){
        self.contentView.layoutIfNeeded()
    }
    
    func setViewWidth(width:CGFloat){
        if width < 30 {
           self.myViewWidth.constant = -(self.contentView.frame.width - (self.contentView.frame.width * 0.125))
            
            
        }else{

            self.contentView.removeConstraint(myViewWidth)
            myViewWidth = NSLayoutConstraint(item: myView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.lessThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 0.7, constant: width   )
            self.contentView.addConstraint(myViewWidth)
        }
       updateLayout()
    }
    
    
    
    func setLableConstraints(){
        lableLeft = NSLayoutConstraint(item: myTitleLable, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: myView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 5)
        myView.addConstraint(lableLeft)
        lableRight = NSLayoutConstraint(item: myTitleLable, attribute: .right, relatedBy: .equal, toItem: myView, attribute: .right, multiplier: 1, constant: -5)
        myView.addConstraint(lableRight)
        lableTop = NSLayoutConstraint(item: myTitleLable, attribute: .top, relatedBy: .equal, toItem: myView, attribute: .top, multiplier: 1, constant: 4)
        myView.addConstraint(lableTop)
        LableBottom = NSLayoutConstraint(item: myTitleLable, attribute: .bottom, relatedBy: .equal, toItem: myView, attribute: .bottom, multiplier: 1, constant: -4)
        myView.addConstraint(LableBottom)
        
        myView.addConstraint(NSLayoutConstraint(item: myimageView, attribute: .left, relatedBy: .equal, toItem: myView, attribute: .left, multiplier: 1, constant: 0))
        myView.addConstraint(NSLayoutConstraint(item: myimageView, attribute: .right, relatedBy: .equal, toItem: myView, attribute: .right, multiplier: 1, constant: 0))
         myView.addConstraint(NSLayoutConstraint(item: myimageView, attribute: .top, relatedBy: .equal, toItem: myView, attribute: .top, multiplier: 1, constant: 0))
         myView.addConstraint(NSLayoutConstraint(item: myimageView, attribute: .bottom, relatedBy: .equal, toItem: myView, attribute: .bottom, multiplier: 1, constant: 0))
        
    }
    func removeLableConstraints(){
        myView.removeConstraint(lableTop)
        myView.removeConstraint(LableBottom)
        myView.removeConstraint(lableRight)
        myView.removeConstraint(lableLeft)
    }
    
    func setViewAnchor(align: Bool){
        if align {
            self.contentView.removeConstraint(myViewAnchor)
            myViewAnchor = NSLayoutConstraint(item: myView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -7)
            self.contentView.addConstraint(myViewAnchor)
            myTitleLable.textAlignment = .right
            myView.backgroundColor = .blue
        }else {
            myView.backgroundColor = UIColor(r: 210, g: 216, b: 219)
            myTitleLable.textAlignment = .left
            self.contentView.removeConstraint(myViewAnchor)
            myViewAnchor = NSLayoutConstraint(item: myView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 7)
            self.contentView.addConstraint(myViewAnchor)
        }
    }
    
    func seturlView(){
         self.myViewWidth.constant =  -(self.contentView.frame.width * 0.5)
        
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
