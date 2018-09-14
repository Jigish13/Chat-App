//
//  ViewController.swift
//  DynamicCellsTV
//
//  Created by Sneh on 12/09/18.
//  Copyright © 2018 The Gateway Corp. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date{
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ViewController: UITableViewController {
    
    fileprivate let cellId = "id123"
    
    let messagesFromServer = [
    ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "8/3/2018")),
    ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "8/3/2018")),
    ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date()),
    ChatMessage(text: "Hello, DONS !!", isIncoming: false, date: Date()),
    ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date())
    ]
    
    var chatMessages = [[ChatMessage]]()
    
    fileprivate func attemptToAssembleGroupedMessages(){
        //print("We r grouping msg's based on Date property...")
        
        let groupedMessages = Dictionary (grouping: messagesFromServer) { (element) -> Date in
            return element.date
        }
        
        //        groupedMessages.keys.forEach { (key) in
        //            //print(key)
        //            let values = groupedMessages[key]
        //            //print(value ?? "")
        //            chatMessages.append(values ?? [])
        //        }
        
        //Lets do grouping after sorting keys i.e. Date here...
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach{ key in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
        
        //print(groupedMessages)
    }
    
    //    let chatMessages = [
    //        [
    //            ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "8/3/2018")),
    //            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "8/3/2018"))
    //        ],
    //        [
    //            ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date()),
    //            ChatMessage(text: "Hello, DONS !!", isIncoming: false, date: Date()),
    //            ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date())
    //        ]
    //    ]
    
    //    let chatMessages = [
    //    ChatMessage(text: "Here's my very first message", isIncoming: true),
    //    ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true),
    //    ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false),
    //    ChatMessage(text: "Hello, DONS !!", isIncoming: false),
    //    ChatMessage(text: "Here's my very first message", isIncoming: true),
    //    ChatMessage(text: "Hello, CHAGAN...", isIncoming: false),
    //    ChatMessage(text: "Bolo MAGAN...", isIncoming: true),
    //    ]
    
    
    //    let txtMessages = ["Here's my very first message","I'm going to message another long message that will word wrap"
    //                        ,"I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap","Hello, DONS !!"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        attemptToAssembleGroupedMessages()
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none //Coz we dont want any seperator line in TV
        
        //tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .black
            textColor = .white
            font = UIFont.boldSystemFont(ofSize: 14)
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize : CGSize{
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = chatMessages[section].first{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            let label = DateHeaderLabel()
            
            label.text = dateString
            
            let containerView = UIView()
            //containerView.ar
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            return containerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        //return "Section: \(section)"
    //        //return "Section: \(Date())" //Date() prints the current date nd time
    //
    //        if let firstMessageInSection = chatMessages[section].first{
    //            let dateFormatter = DateFormatter()
    //            dateFormatter.dateFormat = "MM/dd/yyyy"
    //            let dateString = dateFormatter.string(from: firstMessageInSection.date)
    //            return dateString
    //        }
    //
    //        return "Section: \(section)"
    //    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        //        cell.textLabel?.text = "Copyright © 2018 The Gateway Corp. All rights reserved.Copyright © 2018 The Gateway Corp. All rights reserved.Copyright © 2018 The Gateway Corp. All rights reserved."
        //The above text will be trimed...
        //cell.textLabel?.numberOfLines = 0
        
        //cell.messageLabel.text = txtMessages[indexPath.row]
        //cell.isIncoming = indexPath.row % 2 == 0 //Checks for odd/even
        //let chatMessage = chatMessages[indexPath.row]
        
        //cell.messageLabel.text = chatMessage.text
        // cell.isIncoming = chatMessage.isIncoming
        
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
       
        cell.chatMessage = chatMessage
        
        return cell
    }

}

