//
//  FxPhotoView.swift
//  FXChat
//
//  Created by muhlenXi on 2018/1/11.
//  Copyright © 2018年 PengZhihao. All rights reserved.
//

import UIKit
import SnapKit

class FxPhotoView: UIView {

    lazy var imageView: UIImageView  = {
        let imageView_ = UIImageView()
        imageView_.isUserInteractionEnabled = true
        return imageView_
    }()
    
    lazy var deleteBtn: UIButton = {
        let delete = UIButton()
        delete.setTitle("", for: .normal)
        delete.setImage(UIImage(named: "jianghuDeletePhoto"), for: .normal)
        return delete
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    // MARK: Private method
    func setupSubviews() {
        self.backgroundColor = UIColor.white
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(0)
        }
        self.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.trailing.equalTo(-3)
            make.width.equalTo(16)
            make.height.equalTo(22)
        }
    }

}
