//
//  ItemTableViewCellProtocol.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 02/11/2021.
//

import Foundation

protocol ItemTableViewCellProtocol: AnyObject {
    func plusButtonTapped(cell: ItemTableViewCell)
    func minusButtonTapped(cell: ItemTableViewCell)
}
