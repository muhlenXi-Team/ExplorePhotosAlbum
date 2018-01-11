//
//  ViewController.swift
//  FxNinePhotosExplore
//
//  Created by muhlenXi on 2018/1/11.
//  Copyright © 2018年 muhlenXi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var photoCount = 1
    
    
    lazy var photoAlbum: FxPhotoAlbumView = {
        let album = FxPhotoAlbumView()
        album.backgroundColor = UIColor.yellow
        album.viewDelegate = self
        return album
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(photoAlbum)
        self.photoAlbum.numberOfPhotos = 1
        photoAlbum.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.leading.equalTo(0)
            let width = UIScreen.main.bounds.width
            make.width.height.equalTo(width)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addOneAction(_ sender: UIButton) {
        self.photoCount += 1
        if self.photoCount == 10 {
            self.photoCount = 1
        }
        sender.setTitle("\(self.photoCount)", for: .normal)
        self.photoAlbum.numberOfPhotos = self.photoCount
    }
    
}

extension ViewController: FxPhotoAlbumViewDelegate {
    func onClickPhotoAlbumViewImage(index: Int) {
        print("image index == \(index)")
    }
    
    func onClickPhotoAlbumViewDeleteBtn(index: Int) {
        print("delete image index == \(index)")
    }
}

