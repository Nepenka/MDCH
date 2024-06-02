//
//  CustomCollectionViewSettings.swift
//  MDCH
//
//  Created by 123 on 28.05.24.
//

import Foundation
import UIKit


public func collectionViewSettings(_ collectionView: UICollectionView) {
    collectionView.backgroundColor = .white
    collectionView.isPagingEnabled = true
    collectionView.layer.borderColor = UIColor.black.cgColor
    collectionView.layer.cornerRadius = 10.0
    collectionView.layer.borderWidth = 2.0
    collectionView.layer.masksToBounds = true
}
