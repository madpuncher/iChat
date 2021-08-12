//
//  ViewContrtoller + Extension.swift
//  iChat
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 12.08.2021.
//

import UIKit

extension UIViewController {
    
    func configure<Cell: SelfConfigureCell, U: Hashable>(collectionView: UICollectionView, cellType: Cell.Type, with value: U, indexPath: IndexPath) -> Cell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.resudeId, for: indexPath) as? Cell else { fatalError() }
        
        cell.configure(with: value)
        return cell
    }
    
}
