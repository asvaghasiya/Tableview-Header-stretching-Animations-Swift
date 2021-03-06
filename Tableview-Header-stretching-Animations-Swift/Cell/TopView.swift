//
//  TopView.swift
//  StretchableTableViewHeader
//
//  Created by Artoon Solutions Private Limited on 06/06/19.
//  Copyright © 2019 Artoon Solutions Private Limited. All rights reserved.
//

import UIKit

class TopView: UIView {

    @IBOutlet var albumimage: UIImageView!
    @IBOutlet var albumTitleView: UIView!
    @IBOutlet var albumButton: UIView!
    
    @IBOutlet var albumTopButton: UIView!
    @IBOutlet var btnAlbum: UIButton!
    @IBOutlet var btnMusic: UIButton!
    
    @IBOutlet var albumTop: NSLayoutConstraint!
    @IBOutlet var ButtonBottom: NSLayoutConstraint!
    
    override func awakeFromNib() {
        albumimage.layer.cornerRadius = 5
        btnAlbum.layer.cornerRadius = 3
    }
}
