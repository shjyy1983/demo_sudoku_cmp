//
//  SSSudoKuWall.swift
//  DemoSudoku
//
//  Created by SHEN on 2018/10/11.
//  Copyright © 2018 shj. All rights reserved.
//

import UIKit
import Kingfisher

class SSSudoKuWall: UIView {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(rgb: 0xf5f5f5)
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var imageUrlStrings: [String] = [] {
        didSet {
            drawPlaceholderSudoku()
            downloadImages { [unowned self] (image) in
                self.renderSudoku(image)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SSSudoKuWall deinit")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    private func initView() {
        addSubview(imageView)
        updateLayout()
    }
    
    private func updateLayout() {
        imageView.frame = bounds
    }
    
    private func retrieveImage(_ key: String, completeBlock: @escaping (UIImage?) -> Void) {
        ImageCache.default.retrieveImage(forKey: key, options: nil) { (image, cacheType) in
            completeBlock(image)
        }
    }
    
    fileprivate func downloadImages(_ completeBlock: @escaping (UIImage?) -> Void) {
        // 下载得到的图片
        var images: [UIImage] = []
        
        // 用于判断是否需要进行图片合并成九宫格
        var count = 0
        
        // 遍历下载
        for urlString in imageUrlStrings {
            if let url = URL(string: urlString) {
                // 首先从缓存获取，如果没有则下载
                ImageCache.default.retrieveImage(forKey: urlString, options: nil) { [weak self] image, cacheType in
                    guard let strongSelf = self else {
                        return
                    }
                    if let image = image {
                        count += 1
                        images.append(image)
                        if (count == strongSelf.imageUrlStrings.count) {
                            strongSelf.imageView.image = strongSelf.createSudoku(images)
                        }
                    } else {
                        // 下载
                        print("download")
                        ImageDownloader.default.downloadImage(with: url, retrieveImageTask: nil, options: nil, progressBlock: nil) { [weak self] (image, error, cacheType, url) in
                            if let strongSelf = self, let image = image {
                                count += 1
                                if error == nil {
                                    ImageCache.default.store(image, forKey: urlString)
                                    images.append(image)
                                    print("\(count)")
                                    if (count == strongSelf.imageUrlStrings.count) {
                                        strongSelf.imageView.image = strongSelf.createSudoku(images)
                                    }
                                    print("下载完成")
                                } else {
                                    print("！！下载失败")
                                }
                            }
                        }
                    }
                    
                }
                
            }
        }
    }
    
    fileprivate func drawPlaceholderSudoku() {
        let n = imageUrlStrings.count
        var defaultImages: [UIImage] = []
        for _ in  0..<n {
            if let image = UIImage(named: "defaultAvatar") {
                defaultImages.append(image)
            }
        }
        renderSudoku(createSudoku(defaultImages))
    }
    
    fileprivate func createSudoku(_ images: [UIImage]) -> UIImage? {
        if (images.count == 0) {
            return nil
        }
        let size = imageView.size
        let imageWH = size.width / 3
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        for (i, image) in images.enumerated() {
            let x = CGFloat(i % 3) * imageWH
            let y = CGFloat(i / 3) * imageWH
            image.draw(in: CGRect(x: x, y: y, width: imageWH, height: imageWH))
        }
        let sudokuImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return sudokuImage
    }
    
    fileprivate func renderSudoku(_ image: UIImage?) {
        imageView.image = image
    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
