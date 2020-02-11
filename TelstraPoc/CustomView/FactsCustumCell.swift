//
//  FactsCustumCell.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 11/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import UIKit

class FactsCustumCell: UITableViewCell {

    private let factNameLabel : UILabel = {
           let lbl = UILabel()
           lbl.textColor = .black
           lbl.font = UIFont.boldSystemFont(ofSize: 18)
           lbl.textAlignment = .left
           return lbl
       }()
       
       
       private let factDescriptionLabel : UILabel = {
           let lbl = UILabel()
           lbl.textColor = .black
           lbl.font = UIFont.systemFont(ofSize: 16)
           lbl.textAlignment = .left
           lbl.numberOfLines = 0
           return lbl
       }()
       
       
       private let factImage : UIImageView = {
           let image = UIImage(named: placeholder)
           let imgView = UIImageView(image: image)
          imgView.contentMode = .scaleAspectFit
           imgView.clipsToBounds = true
           return imgView
       }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(factImage)
        addSubview(factNameLabel)
        addSubview(factDescriptionLabel)
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Function to update cell
    func updateContentOnCell(fact:Fact?) {
        guard let factDetails = fact else {
            //print("No Content")
            return
        }
        
        if let tittle = factDetails.factName{
            factNameLabel.text = tittle
        }
        
        
        if let img = factDetails.factImage, img.count > 2{
            DownloadManager.downloadmanager.downloadImage(imageUrl: img, completion: { image in
                DispatchQueue.main.async{ [weak self] in
                    guard let weakSelf = self else { return }
                    if let image = image {
                        weakSelf.factImage.image = image
                    } else {
                        weakSelf.factImage.image = UIImage(named: placeholder)
                    }
                }
            })
        }else{
            self.factImage.image = UIImage(named: placeholder)
        }
        
        if let desc = factDetails.factDesc{
            factDescriptionLabel.text = desc
        }
    }
    
    func updateUI(){
        factImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 90, height: 80, enableInsets: false)
        factNameLabel.anchor(top: topAnchor, left: factImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        factDescriptionLabel.anchor(top: factImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
    }

}
