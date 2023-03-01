//
//  LPWaterFlowLayout.swift
//  LittlePink
//
//  Created by Tingting Wu on 2023/2/25.
//  Copyright © 2023 wtt. All rights reserved.
//

import UIKit

protocol LPWaterFlowLayoutDelegate : AnyObject {
    //返回每个item的高度
    func waterFlowLayout(waterFlowLayout : LPWaterFlowLayout , itemHeightAtIndexPath : NSIndexPath ) -> CGFloat;
}

class LPWaterFlowLayout: UICollectionViewLayout {
    weak var delegate : LPWaterFlowLayoutDelegate?
//    public var colum : Int = 2 //确定列数
//    public var insetSpace : UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)//确定内边距
//    public var rowSpacing : CGFloat = 5.0//行边距
//    public var columnSpacing : CGFloat = 5.0 //列边距
    
    private lazy var columHeightArray : [CGFloat] = [] //存储列高的数组
    private lazy var itemFrameArray : [UICollectionViewLayoutAttributes] = [] //存储所有item的尺寸信息
    
    
    public var colum : Int = 2 {
        willSet {
            if newValue != colum {
                self.colum = newValue
                invalidateLayout()
            }
        }
    }
    
    public var insetSpace : UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        willSet {
            if newValue != insetSpace {
                self.insetSpace = newValue
                invalidateLayout()
            }
        }
    }
    
    public var rowSpacing : CGFloat = 5.0 {
        willSet {
            if newValue != rowSpacing {
                self.rowSpacing = newValue
                invalidateLayout()
            }
        }
    }
    
    public var columnSpacing : CGFloat = 5.0 {
        willSet {
            if newValue != columnSpacing {
                self.columnSpacing = newValue
                invalidateLayout()
            }
        }
    }
    
    //布局,将item的位置信息计算出来
    override func prepare() {
        super.prepare()
        initColumHeightArray()
        initItemFrameArray()
    }
    
    //初始化每一列的初始高度
    private func initColumHeightArray() {
        columHeightArray = Array(repeating: insetSpace.top, count: colum)
    }
    
    private func minColum() -> Int{
        //高度最短的值
        let minHeight = columHeightArray.min()!
        //高度最短的值所在列
        let targetColum = columHeightArray.firstIndex(of: minHeight)!
        return targetColum
    }
    
    private func maxColum() -> Int{
        //高度最长的值
        let maxHeight = columHeightArray.max()!
        //高度最长的值所在列
        let targetColum = columHeightArray.firstIndex(of: maxHeight)!
        return targetColum
    }
    
    //初始化计算全部item的尺寸,存入数组 - 同时存入所有列的高度
    private func initItemFrameArray() {
        //每个item的宽度
        let widthForItem = (collectionView!.view_width - insetSpace.left - insetSpace.right - columnSpacing * CGFloat(colum - 1)) / CGFloat(colum)
        //第一组的item数量
        let countForItem = collectionView!.numberOfItems(inSection: 0)
        //遍历item 计算并缓存属性
        for i in 0 ..< countForItem {
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            //获取动态高度
            let heightForItem = delegate?.waterFlowLayout(waterFlowLayout: self, itemHeightAtIndexPath: indexPath as NSIndexPath)
            
            //y
           //高度最短的值所在列
            let minHeightColum = minColum()
            //获取到该列的 y 坐标
            var itemY = columHeightArray[minHeightColum]
            //判断是否是第一行,如果换行需要加上行间距
            if i >= colum {
                itemY += rowSpacing
            }
            
            //x
            let itemX = insetSpace.left + (widthForItem + columnSpacing) * CGFloat(minHeightColum)
            
            attribute.frame = CGRect(x: itemX, y: itemY, width: widthForItem, height: heightForItem!)
            itemFrameArray.append(attribute)
            
            //更新当前列的高度
            columHeightArray[minHeightColum] = itemY + heightForItem!
        }
    }

    //取得当前item的尺寸
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemFrameArray[indexPath.item]
    }
    
    //根据rect去找出需要布局的item的位置信息
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return itemFrameArray.filter{
            $0.frame.intersects(rect)
        }
    }
    
    override var collectionViewContentSize: CGSize{
        //高度最长的值所在列
        let maxHeightColum = maxColum()
        let maxHeight = columHeightArray[maxHeightColum] + insetSpace.bottom
        return CGSize(width: collectionView!.view_width, height: maxHeight)
    }
    
}
