//
////
////  MessagesCollectionViewCell.swift
////  FireBallProject
////
////  Created by Chaitanya Pandit on 9/25/17.
////  Copyright © 2017 Chaitanya Pandit. All rights reserved.
////
//
//import UIKit
//
//class MessagesCollectionViewCell: UICollectionViewCell{
//
//    var messageLable = UILabel()
//    var messageWidth: CGFloat = (UIScreen.main.bounds.width) / 2
//    var messageHeight: CGFloat =  50 //UIScreen.main.bounds.height
//    var rightLeftAtrribute:NSLayoutAttribute = NSLayoutAttribute.right
//    var messageBubbleWidthAnchor = NSLayoutConstraint()
//    var messageViewBubbleWidthAnchor = NSLayoutConstraint()
//    var messageTextView_right_left_Anchor = NSLayoutConstraint()
//    var messageView_right_left_Anchor = NSLayoutConstraint()
//    var right = NSLayoutAttribute.right
//    var messageImageViewAnchorTop = NSLayoutConstraint()
//    var messageImageViewAnchorBottom = NSLayoutConstraint()
//    var messageImageViewAnchorLeading = NSLayoutConstraint()
//    var messageImageViewAnchorTrailing = NSLayoutConstraint()
//
//
//    var messageView: UIView  = {
//        let myview = UIView()
//        myview.translatesAutoresizingMaskIntoConstraints = false
//        myview.backgroundColor = .blue
//        myview.layer.cornerRadius = 20
//
//        return myview
//    }()
//
//    var messageImageView: UIImageView = {
//        let messageimage = UIImageView()
//        messageimage.translatesAutoresizingMaskIntoConstraints = false
//       return messageimage
//    }()
//
//    var messageTextView: UITextView = {
//        let mytextView = UITextView()
//        mytextView.translatesAutoresizingMaskIntoConstraints = false
//        mytextView.backgroundColor =  UIColor.clear
//        mytextView.textColor  = .white
//        mytextView.isEditable = false
//        mytextView.isScrollEnabled = false
//        mytextView.textAlignment = NSTextAlignment.right
//        mytextView.font = UIFont.systemFont(ofSize: 12)
//        mytextView.textAlignment = NSTextAlignment.right
//        mytextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
//        return mytextView
//    }()
//
//
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(messageView)
//   contentView.addSubview(messageTextView)
////        messageView.addSubview(messageImageView)
//        setConstraintForMessageCell()
//
//
//
//    }
//
//    func setConstraintForMessageCell(){
//
//        messageBubbleWidthAnchor = NSLayoutConstraint(item: messageTextView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: messageWidth)
//
//        contentView.addConstraint(messageBubbleWidthAnchor)
//
//        contentView.addConstraint(NSLayoutConstraint(item: messageTextView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0))
//
//
//        messageTextView_right_left_Anchor = NSLayoutConstraint(item: messageTextView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -10)
//
//        contentView.addConstraint(messageTextView_right_left_Anchor)
//
//        contentView.addConstraint(NSLayoutConstraint(item: messageTextView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
//
//
//        messageViewBubbleWidthAnchor =  NSLayoutConstraint(item: messageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: messageWidth)
//
//
//        contentView.addConstraint(messageViewBubbleWidthAnchor)
//
//        contentView.addConstraint(NSLayoutConstraint(item: messageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0))
//
//
//        messageView_right_left_Anchor = NSLayoutConstraint(item: messageView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -10)
//
//        contentView.addConstraint(messageView_right_left_Anchor)
//
//        contentView.addConstraint(NSLayoutConstraint(item: messageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
//
//        contentView.layoutIfNeeded()
//
//
////         messageImageViewAnchorTop = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
////
////         messageImageViewAnchorBottom = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
////        messageImageViewAnchorLeading = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
////
////         messageImageViewAnchorTrailing = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
////
////        messageView.addConstraint(messageImageViewAnchorTop)
////        messageView.addConstraint(messageImageViewAnchorBottom)
////        messageView.addConstraint(messageImageViewAnchorLeading)
////        messageView.addConstraint(messageImageViewAnchorTrailing)
//
//
//        contentView.layoutIfNeeded()
//
//    }
//
//    func alignmentAnchorSetter(align:Bool){
//
//
//        if align {
//
//            contentView.removeConstraint(messageView_right_left_Anchor)
//
//            messageView_right_left_Anchor = NSLayoutConstraint(item: messageView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -10)
//
//            contentView.addConstraint(messageView_right_left_Anchor)
//
//
//
////            messageView.removeConstraint(messageImageViewAnchorTop)
////            messageView.removeConstraint(messageImageViewAnchorBottom)
////            messageView.removeConstraint(messageImageViewAnchorLeading)
////            messageView.removeConstraint(messageImageViewAnchorTrailing)
////
////
////            messageImageViewAnchorTop = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
////
////            messageImageViewAnchorBottom = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
////            messageImageViewAnchorLeading = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
////
////            messageImageViewAnchorTrailing = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
////
////            messageView.addConstraint(messageImageViewAnchorTop)
////            messageView.addConstraint(messageImageViewAnchorBottom)
////            messageView.addConstraint(messageImageViewAnchorLeading)
////            messageView.addConstraint(messageImageViewAnchorTrailing)
//
//
//            contentView.removeConstraint(messageTextView_right_left_Anchor)
//
//
//            messageTextView_right_left_Anchor = NSLayoutConstraint(item: messageTextView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -10)
//            contentView.addConstraint(messageTextView_right_left_Anchor)
//
//
//
//
//            messageTextView.textAlignment = NSTextAlignment.right
//            messageTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
//
//
//            messageTextView.textColor = UIColor.white
//
//            messageView.backgroundColor = .blue
//            contentView.layoutIfNeeded()
//
//
//
//        }else{
//
//            messageTextView.textColor = UIColor.black
//            messageView.backgroundColor = UIColor(r: 210, g: 216, b: 219)
//            messageTextView.textAlignment = NSTextAlignment.left
//            messageTextView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
////
//            contentView.removeConstraint(messageView_right_left_Anchor)
//
//            messageView_right_left_Anchor = NSLayoutConstraint(item: messageView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 10)
//
//            contentView.addConstraint(messageView_right_left_Anchor)
//
//
//
//            contentView.removeConstraint(messageTextView_right_left_Anchor)
//
//
//            messageTextView_right_left_Anchor = NSLayoutConstraint(item: messageTextView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 10)
//
//            contentView.addConstraint(messageTextView_right_left_Anchor)
//
//
//
////            messageView.removeConstraint(messageImageViewAnchorTop)
////            messageView.removeConstraint(messageImageViewAnchorBottom)
////            messageView.removeConstraint(messageImageViewAnchorLeading)
////            messageView.removeConstraint(messageImageViewAnchorTrailing)
////
////            messageImageViewAnchorTop = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
////
////            messageImageViewAnchorBottom = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
////            messageImageViewAnchorLeading = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
////
////            messageImageViewAnchorTrailing = NSLayoutConstraint(item: messageImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: messageView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
////
////            messageView.addConstraint(messageImageViewAnchorTop)
////            messageView.addConstraint(messageImageViewAnchorBottom)
////            messageView.addConstraint(messageImageViewAnchorLeading)
////            messageView.addConstraint(messageImageViewAnchorTrailing)
//            contentView.layoutIfNeeded()
//        }
//
//    }
//
//
//
//    func widthAnchorSetter(width:CGFloat){
//
//        if width < 52.92578125 {
//            messageViewBubbleWidthAnchor.constant = 52.92578125
//            messageBubbleWidthAnchor.constant = 52.92578125
//          //  messageImageViewAnchorTop.constant = 52.92578125
//            contentView.layoutIfNeeded()
//
//        }else {
//            messageViewBubbleWidthAnchor.constant = width
//            messageBubbleWidthAnchor.constant = width
////            messageImageViewAnchorTop.constant = width
//            contentView.layoutIfNeeded()
//        }
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

