//
//  VideoPlayerController.swift
//  Hawkeye Mobile
//
//  Created by M Tayyab on 20/11/2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class VideoPlayerController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var bottomViewBC: NSLayoutConstraint!
    
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let preferences = UserDefaults.standard
    
    // Get a reference to the storage service using the default Firebase App
    var ref: DatabaseReference!
    let storage = Storage.storage()
    
    var userId = ""
    var messages: [MessageModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Some other comment.
        ref = Database.database().reference()
        
        getMessages()
        
        
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification,object: nil)
        
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification,object: nil)
        
        
        
        messagesTableView.dataSource=self
        messagesTableView.delegate=self
        messageTextField.delegate=self
        
        
        
        if self.preferences.object(forKey: "currentUserId") == nil {
            //  Doesn't exist
            guard let key = ref.childByAutoId().key else { return }
            
            self.preferences.set(key, forKey: "currentUserId")
            userId = key
            
        } else {
            let currentLevel = preferences.value(forKey: "currentUserId")
            
            userId = currentLevel! as! String
            
        }
        
        
        
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        
        
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject> {
            
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height as? CGFloat {
                self.bottomViewBC.constant = -(keyBoardHeight - 50)
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    @objc func keyBoardWillHide(notification: NSNotification) {
        
        self.bottomViewBC.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func sendBtn_Clicked(_ sender: Any) {
        
        guard let textFromField = messageTextField.text else { return }
        if textFromField != "" {
            
            self.saveMessage(message: textFromField,type: "text")
        }
        
    }
    
    func saveMessage(message audUrl: String,type typ: String) {
        
        
        let preciseMilliseconds = Int64(NSDate().timeIntervalSince1970 * 1_000)
        let model = MessageModel(message: audUrl, sender: "-1", timestamp: preciseMilliseconds, type: typ)
        
        
        
        
        
        guard let key = ref.childByAutoId().key else { return }
        
        
        
        
        let data : Dictionary<String, Any> = ["message" : audUrl, "sender" : userId, "timestamp" : preciseMilliseconds, "type" : typ]
        ref.child("Groups").child("public_chat_room").child("messages").child(key).setValue(data)
        
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        let timee: String = dateFormatter.string(from: currentDate)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let datee: String = dateFormatter.string(from: currentDate)
        
        if true {
            
            let chatGroupSender : Dictionary<String, Any> = ["id" : "public_chat_room", "name" : "namehere", "receiver_id" : "public"]
            let chatGroupReceiver : Dictionary<String, Any> = ["id" : "public_chat_room", "name" : "MyName", "receiver_id" : userId]
            
            
            
            ref.child("Users").child(userId).child("chat_groups").child("public_chat_room").setValue(chatGroupSender)
            ref.child("Users").child("public").child("chat_groups").child("public_chat_room").setValue(chatGroupReceiver)
            
            ref.child("Users").child("public").child("name").setValue("namehere")
            ref.child("Users").child(userId).child("name").setValue("MyName")
            
        }
        
        
        ref.child("Users").child(userId).child("last_date").setValue(datee)
        ref.child("Users").child(userId).child("last_time").setValue(timee)
        
        ref.child("Users").child("public").child("last_date").setValue(datee)
        ref.child("Users").child("public").child("last_time").setValue(timee)
        
        
        
        messages.append(model)
        messagesTableView.beginUpdates()
        messagesTableView.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .fade)
        messagesTableView.endUpdates()
        messagesTableView.scrollToRow(at: IndexPath(row: messages.count - 1,section: 0), at: .top, animated: true)
        //useFirstAttribute = !useFirstAttribute
        messageTextField.text = nil
        
    }
    
    
    func getMessages() {
        
        
//        let messageModell = MessageModel(message: "Hello How are you?", sender: "", timestamp: 0, type: "")
//        self.messages.append(messageModell)
        
        
        self.startLoading()
        self.ref.child("Groups").child("public_chat_room").child("messages").observe(.value, with: { (snapshot) in
            
            self.stopLoading()
            self.messages.removeAll()
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                
                let value = rest.value as? NSDictionary
                //let imagekey = value?["image_key"] as? String ?? ""
                let message = value?["message"] as? String ?? ""
                let post_id = value?["post_id"] as? String ?? ""
                let sender = value?["sender"] as? String ?? ""
                let timestamp = value?["timestamp"] as? Int64 ?? 0
                let type = value?["type"] as? String ?? ""
                
                let messageModell = MessageModel(message: message, sender: sender, timestamp: timestamp, type: type)
                
                self.messages.append(messageModell)
            }
            self.messagesTableView.reloadData()
            self.messagesTableView.scrollToRow(at: IndexPath(row: self.messages.count - 1,section: 0), at: .top, animated: true)
            
            
            
        })
        
    }
    
    func stopLoading() {
        
        activityIndicator.stopAnimating()
    }
    func startLoading() {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messgeCell", for: indexPath) as!
        MessageTableViewCell
        
        cell.updateMessageCell(by: messages[indexPath.row])
        
        //cell.cellDelegte = self
        //cell.index = indexPath
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
