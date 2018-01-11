//
//  FxPhotoAlbumView.swift
//  FXChat
//
//  Created by muhlenXi on 2018/1/11.
//  Copyright © 2018年 PengZhihao. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let tagBase = 900

protocol FxPhotoAlbumViewDelegate: class {
    func onClickPhotoAlbumViewImage(index: Int)
    func onClickPhotoAlbumViewDeleteBtn(index: Int)
}

class FxPhotoAlbumView: UIView {
    
    weak var viewDelegate: FxPhotoAlbumViewDelegate?
    
    var topSpace: CGFloat = 10.0    // 顶部间隙
    var bottomSpace: CGFloat = 10.0 // 底部间隙
    var leftSpace: CGFloat = 10      // 左边间隙
    var rightSpace: CGFloat = 10     // 右边间隙
    var imageSpace: CGFloat = 10    // 图片间间隙
    var isShowDelete: Bool = true   // 是否显示删除按钮
    var isTwoRowsTwoColumns: Bool = true  // 四张照片是否是两行两列显示
    
    var imageWidth: CGFloat {
        get {
            let imageWidth = (UIScreen.main.bounds.size.width-leftSpace-rightSpace-imageSpace*2)/3.0
            let imageHeight = (UIScreen.main.bounds.size.width-topSpace-bottomSpace-imageSpace*2)/3.0
            return min(imageWidth, imageHeight)
        }
    }
    // 图片赋值
    var images: [UIImage] = [UIImage]() {
        didSet {
            if images.count > 0 {
                for (index, image) in images.enumerated() {
                    getPhotoViewWithTag(tag: index+tagBase)!.imageView.image = image
                }
            }
        }
    }
    
    // 单张图片的宽和高
    var onlyAPhotoWidth: CGFloat = 100
    
    var numberOfPhotos: Int = 1 {
        didSet {
            // 移除以前的
            removeAllPhotoViews()
            // 添加新的
            addPhotoViewsByCount(count: numberOfPhotos)
            // 添加约束
            switch numberOfPhotos {
            case 1:
                addConstraintToOnePhotos()
            case 2:
                addConstraintToTwoPhotos()
            case 3:
                addConstraintToThreePhotos()
            case 4:
                if isTwoRowsTwoColumns {
                    addConstraintToFourPhotos_double2()
                } else {
                    addConstraintToFourPhotos_normal()
                }
            case 5:
                addConstraintToFivePhotos()
            case 6:
                addConstraintToSixPhotos()
            case 7:
                addConstraintToSevenPhotos()
            case 8:
                addConstraintToEightPhotos()
            case 9:
                addConstraintToNinePhotos()
            default:
                break
            }
        }
    }
    
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
        
    }
    
    func addPhotoViewsByCount(count: Int) {
        for i in 0..<count {
            let photoView = FxPhotoView()
            photoView.tag = tagBase + i
            photoView.deleteBtn.isHidden = !isShowDelete
            
            //添加事件
            photoView.deleteBtn.addTarget(self, action: #selector(self.onClickDeleteBtn(_:)), for: .touchUpInside)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTapImageView(_:)))
            photoView.imageView.addGestureRecognizer(tap)
            
            self.addSubview(photoView)
        }
    }
    
    func getPhotoViewWithTag(tag: Int) -> FxPhotoView? {
        if let view = self.viewWithTag(tag) as? FxPhotoView {
            return view
        }
        return nil
    }
}

// MARK: - onClickEvents
extension FxPhotoAlbumView {
    @objc func onClickDeleteBtn(_ sender: UIButton) {
        if let view = sender.superview as? FxPhotoView {
           self.viewDelegate?.onClickPhotoAlbumViewDeleteBtn(index: view.tag - tagBase)
        }
    }
    
    @objc func onTapImageView(_ sender: UITapGestureRecognizer) {
        if let view = sender.view?.superview as? FxPhotoView {
            self.viewDelegate?.onClickPhotoAlbumViewImage(index: view.tag - tagBase)
        }
    }
}

// MARK: - add constraints
extension FxPhotoAlbumView {
    func addConstraintToOnePhotos() {
        removeAllPhotosContraint()
        if let photo = getPhotoViewWithTag(tag: tagBase+0) {
            photo.snp.makeConstraints({ (make) in
                make.top.equalTo(topSpace)
                make.leading.equalTo(leftSpace)
                make.width.equalTo(onlyAPhotoWidth)
                make.bottom.equalTo(-bottomSpace)
            })
        }
    }
    
    func addConstraintToTwoPhotos() {
        removeAllPhotosContraint()
        let photo = getPhotoViewWithTag(tag: tagBase+0)!
        photo.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo2 = getPhotoViewWithTag(tag: tagBase+1)!
        photo2.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace)
            make.leading.equalTo(photo.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func addConstraintToThreePhotos() {
        removeAllPhotosContraint()
        let photo = getPhotoViewWithTag(tag: tagBase+0)!
        photo.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo2 = getPhotoViewWithTag(tag: tagBase+1)!
        photo2.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace)
            make.leading.equalTo(photo.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo3 = getPhotoViewWithTag(tag: tagBase+2)!
        photo3.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace)
            make.leading.equalTo(photo2.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func addConstraintToFourPhotos_normal() {
        addConstraintToThreePhotos()
        let photo3 = getPhotoViewWithTag(tag: tagBase+3)!
        photo3.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace+imageWidth+imageSpace)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func addConstraintToFourPhotos_double2() {
        addConstraintToTwoPhotos()
        let photo2 = getPhotoViewWithTag(tag: tagBase+2)!
        photo2.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace+imageWidth+imageSpace)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo3 = getPhotoViewWithTag(tag: tagBase+3)!
        photo3.snp.makeConstraints({ (make) in
            make.top.equalTo(photo2.snp.top)
            make.leading.equalTo(photo2.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func addConstraintToFivePhotos() {
        addConstraintToThreePhotos()
        let photo3 = getPhotoViewWithTag(tag: tagBase+3)!
        photo3.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace+imageWidth+imageSpace)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo4 = getPhotoViewWithTag(tag: tagBase+4)!
        photo4.snp.makeConstraints({ (make) in
            make.top.equalTo(photo3.snp.top)
            make.leading.equalTo(photo3.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func addConstraintToSixPhotos() {
        addConstraintToThreePhotos()
        let photo3 = getPhotoViewWithTag(tag: tagBase+3)!
        photo3.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace+imageWidth+imageSpace)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo4 = getPhotoViewWithTag(tag: tagBase+4)!
        photo4.snp.makeConstraints({ (make) in
            make.top.equalTo(photo3.snp.top)
            make.leading.equalTo(photo3.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo5 = getPhotoViewWithTag(tag: tagBase+5)!
        photo5.snp.makeConstraints({ (make) in
            make.top.equalTo(photo3.snp.top)
            make.leading.equalTo(photo4.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func addConstraintToSevenPhotos() {
        addConstraintToSixPhotos()
        let photo6 = getPhotoViewWithTag(tag: tagBase+6)!
        photo6.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace+(imageWidth+imageSpace)*2)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func addConstraintToEightPhotos() {
        addConstraintToSixPhotos()
        let photo6 = getPhotoViewWithTag(tag: tagBase+6)!
        photo6.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace+(imageWidth+imageSpace)*2)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo7 = getPhotoViewWithTag(tag: tagBase+7)!
        photo7.snp.makeConstraints({ (make) in
            make.top.equalTo(photo6.snp.top)
            make.leading.equalTo(photo6.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func addConstraintToNinePhotos() {
        addConstraintToSixPhotos()
        let photo6 = getPhotoViewWithTag(tag: tagBase+6)!
        photo6.snp.makeConstraints({ (make) in
            make.top.equalTo(topSpace+(imageWidth+imageSpace)*2)
            make.leading.equalTo(leftSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo7 = getPhotoViewWithTag(tag: tagBase+7)!
        photo7.snp.makeConstraints({ (make) in
            make.top.equalTo(photo6.snp.top)
            make.leading.equalTo(photo6.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
        let photo8 = getPhotoViewWithTag(tag: tagBase+8)!
        photo8.snp.makeConstraints({ (make) in
            make.top.equalTo(photo6.snp.top)
            make.leading.equalTo(photo7.snp.trailing).offset(imageSpace)
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth)
        })
    }
    
    func removeAllPhotosContraint() {
        for i in 0..<9 {
            if let photo = getPhotoViewWithTag(tag: tagBase+i) {
                photo.snp.removeConstraints()
            }
        }
    }
    
    func removeAllPhotoViews() {
        for i in 0..<9 {
            if let photo = getPhotoViewWithTag(tag: tagBase+i) {
                photo.removeFromSuperview()
            }
        }
    }
    
    func setAllPhotosImageToNil() {
        for i in 0..<9 {
            if let photo = getPhotoViewWithTag(tag: tagBase+i) {
                photo.imageView.image = nil
            }
        }
    }
}

