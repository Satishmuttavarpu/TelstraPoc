//
//  ProductCustomCell.swift
//  TelstraPoc
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import UIKit

class ProductCustomCell: UITableViewCell {
    
    public let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let productImage : UIImageView = {
        let image = UIImage(named: "placeholder")
        let imgView = UIImageView(image: image)
       imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImage)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Function to update cell
    func updateContentOnCell(product:Product?) {
        guard let productDetails = product else {
            //print("No Content")
            return
        }
        
        if let tittle = productDetails.productName{
            productNameLabel.text = tittle
        }
        
        
        if let img = productDetails.productImage, img.count > 2{
            DownloadManager.downloadmanager.downloadImage(imageUrl: img, completion: { image in
                DispatchQueue.main.async{ [weak self] in
                    guard let weakSelf = self else { return }
                    if let image = image {
                        weakSelf.productImage.image = image
                    } else {
                        weakSelf.productImage.image = UIImage(named: placeholder)
                    }
                }
            })
        }else{
            self.productImage.image = UIImage(named: placeholder)
        }
        
        if let desc = productDetails.productDesc{
            productDescriptionLabel.text = desc
        }
    }
    
    func updateUI(){
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 90, height: 80, enableInsets: false)
        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        productDescriptionLabel.anchor(top: productImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
    }

}
