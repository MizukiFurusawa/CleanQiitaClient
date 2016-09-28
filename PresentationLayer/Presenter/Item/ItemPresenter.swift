//
//  ItemPresenter.swift
//  CleanQiitaClient
//
//  Created by Takahiro Nishinobu on 2016/09/25.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import Foundation

protocol ItemPresenter {
    
    weak var view: ItemPresenterView? { get set }
    
    func setupUI()
    func refreshData()
    func tappedStock()
    func tappedUser(userId: String)
    
}

protocol ItemPresenterView: class {
    
    func setupNavigation(title: String)
    func setupTableSeparatorStyleNone()
    func setupRefreshControl()
    func reloadView(itemSummaryVM: ItemSummaryProtocol)
    func segueItemListOfSelectedUser(userId: String)
    
}