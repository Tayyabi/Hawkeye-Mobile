//
//  MessageTableViewCell.swift
//  Hawkeye Mobile
//
//  Created by M Tayyab on 20/11/2021.
//

import UIKit


class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageBackgroundView: UIView!
    
   // @IBOutlet weak var messageImage: UIImageView!
    var trailingContraint: NSLayoutConstraint!
    var leadingContraint: NSLayoutConstraint!
    
    
    var index: IndexPath?
    
    let preferences = UserDefaults.standard
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //messageBackgroundView.addSubview(audioBtn)
        //messageBackgroundView.addSubview(audioSlider)
        //audioBtn = nil
        //audioSlider = nil
        messageLabel.text = nil
        //messageImage.image = nil
        leadingContraint.isActive = false
        trailingContraint.isActive = false
    }
    
    
    func updateMessageCell(by message: MessageModel) {
        
        messageBackgroundView.layer.cornerRadius=16
        messageBackgroundView.clipsToBounds=true
        
        trailingContraint = messageBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20)
        
        leadingContraint = messageBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20)
        
//        if message.type == "audio" {
//            audioUrl = message.message
//            messageLabel.text = "                             2:00"
//        }
//        else {
            messageLabel.text = message.message
            //audioBtn.removeFromSuperview()
            //audioSlider.removeFromSuperview()
            
            
      //  }
        
        let myStringId = preferences.value(forKey: "currentUserId")
        
        //let myStringId = String(currentId)
        if message.sender == myStringId as! String {
            
            
            nameLbl.isHidden = false
            nameLbl.textAlignment = .right
            
            messageBackgroundView.backgroundColor = UIColor(red: 53/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1.0)
            trailingContraint.isActive=true
            messageLabel.textAlignment = .right
            
//            if message.image_key! != "" {
//                var array = message.image_key!.components(separatedBy: ",")
//                array = array.filter {$0 != ""}
//                messageImage.downloaded(from: getCorrectUrl(key: array[0]))
//                // messageImage.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
//
//
//
//                let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:300))
//                let ratio = messageImage.frame.size.width / messageImage.frame.size.height
//                if containerView.frame.width > containerView.frame.height {
//                    let newHeight = containerView.frame.width / ratio
//                    messageImage.frame.size = CGSize(width: containerView.frame.width, height: newHeight)
//                }
//                else{
//                    let newWidth = containerView.frame.height * ratio
//                    messageImage.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
//                }
//            }
        }
        else {
            
            nameLbl.isHidden = false
            nameLbl.textAlignment = .left
            messageBackgroundView.backgroundColor = UIColor(red: 83/255.0, green: 167/255.0, blue: 93/255.0, alpha: 1.0)
            leadingContraint.isActive=true
            messageLabel.textAlignment = .left
            
//            if message.image_key! != "" {
//                var array = message.image_key!.components(separatedBy: ",")
//                array = array.filter {$0 != ""}
//                messageImage.downloaded(from: getCorrectUrl(key: array[0]))
//                //messageImage.frame.size = CGRect(x: 0, y: 0, width: 200, height: 200)
//
//                let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:300))
//                let ratio = messageImage.frame.size.width / messageImage.frame.size.height
//                if containerView.frame.width > containerView.frame.height {
//                    let newHeight = containerView.frame.width / ratio
//                    messageImage.frame.size = CGSize(width: containerView.frame.width, height: newHeight)
//                }
//                else{
//                    let newWidth = containerView.frame.height * ratio
//                    messageImage.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
//                }
//            }
        }
    }
    
    
//    @IBAction func audioPlayClick(_ sender: Any) {
//
//
//        cellDelegte?.onClickPlayAudioMsg(index: index!.row, playBtn: audioBtn, audioSlider: audioSlider)
//
//
//    }
//
//    @IBAction func changeAudioTimee(_ sender: Any) {
//        player?.stop()
//        player?.currentTime = TimeInterval(audioSlider.value)
//        player?.prepareToPlay()
//        player?.play()
//    }
    
//    func getCorrectUrl(key mykey: String) -> String {
//        var imgUrl = ""
//        if mykey.hasSuffix(".jpg")
//        {
//            imgUrl = "https://s3.amazonaws.com/qurbaniimages/" + mykey + ".jpeg"
//
//        }
//        else if mykey.hasSuffix(".png")
//        {
//            imgUrl = "https://s3.amazonaws.com/qurbaniimages/" + mykey + ".png"
//
//        }
//        else {
//            imgUrl = "https://s3.amazonaws.com/qurbaniimages/" + mykey
//
//            imgUrl = imgUrl.replacingOccurrences(of: "+", with: "%252B", options: .literal, range: nil)
//        }
//        return imgUrl
//    }
}
