//
//  ChatMessageCell.swift
//  DynamicCellsTV
//
//  Created by Sneh on 12/09/18.
//  Copyright © 2018 The Gateway Corp. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatMessage: ChatMessage!{
        didSet{
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .black
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming{
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    //    var isIncoming: Bool!{
    //        didSet{
    //           // print(134) //jetla cells hse tv ma etli var print krse on console
    //            bubbleBackgroundView.backgroundColor = isIncoming ? .white : .darkGray
    //            messageLabel.textColor = isIncoming ? .black : .white 
    //        }
    //    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear //It will clear the bg color of cell nd je tv no bg color hse ee set thai jse by default for cell
        
        bubbleBackgroundView.backgroundColor = .blue
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        
        addSubview(messageLabel)
        //messageLabel.backgroundColor = .green
        //messageLabel.textColor = .white
        messageLabel.font = UIFont.boldSystemFont(ofSize: 18)
        messageLabel.numberOfLines = 0
        messageLabel.text = "SOME MESSAGE OVER HERE...  Copyright © 2018 The Gateway Corp. All rights reserved. OKAY tata-tata !!"
        //messageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        //Lets use Autolayout for this label OR lets set some constraints for our label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
        messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        //messageLabel.widthAnchor.constraint(equalToConstant: 250), //Note: Trailing ni jagiya width anchor sue kriyo
           
            //NOTE: Agr msg obj nano hse, then 250 width vadhare pdse ene so set in such a way that dynamically msg ne wrap kre
            //      such that max width 250 hoi...
            
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        
        // CODE TO WRAP-CONTENT IN BUBBLE...
        //        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: 0),
        //        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: 0),
        //        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 0),
        //        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 0)
        
        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32)
        leadingConstraint.isActive = true
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
