//
//  ItemPresenterImplFromAllItem.swift
//  CleanQiitaClient
//
//  Created by Takahiro Nishinobu on 2016/09/25.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import Foundation
import DomainLayer

public class ItemPresenterImplFromAllItem: ItemPresenter {
    
    weak public var view: ItemPresenterView?
    let useCase: ItemUseCase
    
    private var itemModel: ItemModel!
    
    public init(useCase: ItemUseCase) {
        self.useCase = useCase
    }
    
    public func setupUI() {
        view?.setupNavigation(title: "投稿")
        view?.setupTable()
        view?.setupRefreshControl()
    }
    
    public func refreshData() {
        useCase.fetchItem { [weak self] result in
            guard let itemModel = result.value else {
                return
            }
            self?.itemModel = itemModel
            self?.reloadView(itemModel: itemModel)
        }
    }
    
    public func tappedUser(userId: String) {
        view?.segueItemListOfSelectedUser(userId: userId)
    }
    
    public func tappedStock() {
        if itemModel.hasStock {
            deleteStock()
        } else {
            putStock()
        }
    }
    
    private func putStock() {
        useCase.putStock { [weak self] result in
            
            guard let weakSelf = self else {
                return
            }
            weakSelf.itemModel.updateHasStock(state: true)
            weakSelf.reloadView(itemModel: weakSelf.itemModel)
        }
    }
    
    private func deleteStock() {
        useCase.deleteStock { [weak self] result in
            
            guard let weakSelf = self else {
                return
            }
            weakSelf.itemModel.updateHasStock(state: false)
            weakSelf.reloadView(itemModel: weakSelf.itemModel)
            
        }
    }
    
    private func reloadView(itemModel: ItemModel) {
        let itemSummaryVM = ItemSummaryVM(itemModel: itemModel)
        view?.reloadView(itemSummaryVM: itemSummaryVM)
    }
    
}
