//
//  MainViewController.swift
//  UITest0214
//
//  Created by Defalt Lee on 2022/2/14.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var safeAreaInset: UIEdgeInsets?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeAreaInset = UIApplication.shared.windows.first?.safeAreaInsets
        
        setCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addViewOnCollectionView()
    }
    
    func setCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        setCollectionViewLayout()
        
        registerCollectionViewCell()
    }
    
    func registerCollectionViewCell() {
        var nib: UINib?
        
        nib = UINib(nibName: MyCollectionViewCell.cellIdentifier, bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: MyCollectionViewCell.cellIdentifier)
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: topView.frame.height - safeAreaInset!.top + 110, left: 2, bottom: 0, right: 2)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 2
        
        myCollectionView.collectionViewLayout = layout
    }
    
    func addViewOnCollectionView() {
        let containerView = UIView(frame: CGRect(x: 2, y: topView.frame.height - safeAreaInset!.top + 4, width: UIScreen.main.bounds.width - 4, height: 102))
        containerView.backgroundColor = .yellow
        
        let viewA = UIView(frame: CGRect(x: -2, y: 4, width: UIScreen.main.bounds.width, height: 45))
        viewA.backgroundColor = .red
        
        let viewB = UIView(frame: CGRect(x: -2, y: 53, width: UIScreen.main.bounds.width, height: 45))
        viewB.backgroundColor = .green
        
        containerView.addSubview(viewA)
        containerView.addSubview(viewB)
        myCollectionView.addSubview(containerView)
        
        // ??????????????????
        viewB.translatesAutoresizingMaskIntoConstraints = false
        
        // ????????????????????????????????????????????????0
        let consTopOne = NSLayoutConstraint(item: viewB,
                                            attribute: .top,
                                            relatedBy: .greaterThanOrEqual,
                                            toItem: topView,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: 0)
        
        // ????????????????????????
        consTopOne.priority = UILayoutPriority(1000)    // ????????????????????? 1000
        
        // ??????????????????????????????????????????-4
        let consTopTwo = NSLayoutConstraint(item: viewB,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: containerView,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: -4)
        
        // ????????????????????????
        consTopTwo.priority = UILayoutPriority(999)
        
        // ?????????????????????????????????????????????
        
        // ????????????
        let consCenter = NSLayoutConstraint(item: viewB, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        // ????????????
        let consHeight = NSLayoutConstraint(item: viewB, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45)
        // ????????????
        let consWidth = NSLayoutConstraint(item: viewB, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width)
        
        // ????????????
        self.view.addConstraints([consTopOne, consTopTwo, consCenter, consHeight, consWidth])

        
        
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.cellIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.cellView.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 12) / 3, height: (UIScreen.main.bounds.width - 12) / 3)
    }
    
}
