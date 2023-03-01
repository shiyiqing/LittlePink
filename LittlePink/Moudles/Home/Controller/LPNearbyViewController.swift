//
//  LPNearbyViewController.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/27.
//  Copyright © 2023 wtt. All rights reserved.
//


import UIKit
import SnapKit

class LPNearbyViewController: LPBaseViewController, LPWaterFlowLayoutDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .randomColor
        return cell
    }
    
    func waterFlowLayout(waterFlowLayout: LPWaterFlowLayout, itemHeightAtIndexPath: NSIndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 50)
    }
    
    private let cellId = "LPFindViewControllerCollectionViewCell"
    var itemCount : Int = 300
    var collectionView : UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink
        setupSubViews()
    }
    
    private func setupSubViews(){
        let layout = LPWaterFlowLayout()
        layout.colum = 1
        layout.delegate = self
        
        let margin : CGFloat = 8
        layout.insetSpace = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        //现在view的大小还不规定      为全部屏幕的大小   现在设置了大小 但是childvc在自定义的vc里面改变了大小。但是UICollectionView的大小未更新
        //使用snapkit 或者 设置子view autoresizingMask 也不太管用
        //'UICollectionView must be initialized with a non-nil layout parameter'
//        collectionView = UICollectionView()
//        collectionView?.collectionViewLayout = layout
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
//        view.autoresizingMask = .flexibleHeight
//        collectionView?.contentInsetAdjustmentBehavior = .never
        collectionView?.backgroundColor = .systemCyan
        collectionView?.dataSource = self
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView!)
        
        collectionView?.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

}
