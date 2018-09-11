//
//  BannerTableViewCell.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/20.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var advCollectionView: UICollectionView!
    fileprivate let scrollCellIdentifier = String(describing: BannerCollectionViewCell.self)
    @IBOutlet weak var allView: UIView!
    fileprivate var flowLayout: UICollectionViewFlowLayout!
    fileprivate var itemSize: CGSize!
    fileprivate var insideColumnMargin: CGFloat!
    fileprivate var insideRowMargin: CGFloat!
    fileprivate var outsideMargin: CGFloat!
    var subject: SubjectDetailData?
    
    var itemsCounts: Int = 0 {
        didSet {
            if itemsCounts > 1 {
                pageControl.isHidden = false
                removeTimer()
                setUpPageControl()
                setUpTimer()
            } else {
                pageControl.isHidden = true
            }
        }
    }
    var advertisementArr: [SlideImage]? {
        didSet {
            if let advertisementArr = advertisementArr {
                advCollectionView.reloadData()
                itemsCounts = advertisementArr.count
            }
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    fileprivate var timer:Timer?
    var autoScrollDelay:TimeInterval = 2
    var didSelectBannerBlock: ((_ model: SlideImage) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outsideMargin = 18
        insideColumnMargin = 0
        insideRowMargin = 28

        let itemWidth: CGFloat = UIScreen.main.bounds.width
        let itemHeight: CGFloat = 160
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        
        advCollectionView.delegate = self
        advCollectionView.dataSource = self
        advCollectionView.backgroundColor = .clear
        advCollectionView.alwaysBounceVertical = true
        advCollectionView.showsVerticalScrollIndicator = false
        advCollectionView.showsHorizontalScrollIndicator = false
        advCollectionView.bounces = false
        advCollectionView.isPagingEnabled = true

       advCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"BannerCollectionViewCell")

    }
    
    
    
    private func setUpTimer(){
        timer = Timer.init(timeInterval: autoScrollDelay, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
    
     private func setUpPageControl() {
       
        pageControl?.pageIndicatorTintColor = UIColor.white
        pageControl?.currentPageIndicatorTintColor = UIColor(red: 74/255, green: 144/255, blue: 255/255, alpha: 1)
        pageControl?.numberOfPages = itemsCounts
        pageControl?.currentPage = 0

    }
    
    @objc private func autoScroll(){
        
        var offset: NSInteger = NSInteger(self.advCollectionView.contentOffset.x / self.bounds.size.width)

        if offset == 0 || offset == (itemsCounts - 1) {
            if offset == 0 {

                self.advCollectionView.setContentOffset(CGPoint.init(x: CGFloat(offset + 1) * self.bounds.size.width, y: 0), animated: true)

            }else {
                offset = 0
                self.advCollectionView.setContentOffset(CGPoint.init(x: CGFloat(offset) * self.bounds.size.width, y: 0), animated: true)

            }

        }else{

            self.advCollectionView.setContentOffset(CGPoint.init(x: CGFloat(offset + 1) * self.bounds.size.width, y: 0), animated: true)

        }
    }
    
    @objc private func removeTimer(){
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
    }
    
    deinit {
        removeTimer()
    }
    
    
    
    
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setUpTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        let currentPage:NSInteger = NSInteger(scrollView.contentOffset.x / scrollView.bounds.size.width)
        let currentPageIndex = itemsCounts > 0 ? currentPage % itemsCounts : 0
        self.pageControl?.currentPage = currentPageIndex
        
    }

}

extension BannerTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension BannerTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let array = advertisementArr, array.count > 0 {
            let model = array[indexPath.item]
            if let block = self.didSelectBannerBlock {
                block(model)
            }
        }
    }
}

extension BannerTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemsCounts
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: scrollCellIdentifier,
                                                      for: indexPath) as! BannerCollectionViewCell
        if let images = advertisementArr {
            let imageModel = images[indexPath.row]
            item.image = imageModel
        }
        return item
    }
}

