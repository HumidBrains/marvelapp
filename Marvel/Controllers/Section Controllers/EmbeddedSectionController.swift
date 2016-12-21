//
//  HorizontalSectionController.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Foundation
import IGListKit

class EmbeddedSectionController: IGListSectionController, IGListSectionType {
    
    var apiManager: MarvelAPICalls = MarvelAPIManager()
    
    lazy var adapter: IGListAdapter = {
        let adapter = IGListAdapter(updater: IGListAdapterUpdater(),
                                    viewController: self.viewController,
                                    workingRangeSize: 3)
        adapter.dataSource = self
        adapter.delegate = self
        return adapter
    }()
    
    var events: [Portrait] = [] {
        didSet {
        adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    func fetchEvents() {
        apiManager.event { events in
            if let events = events {
                self.events += self.mapToPortrait(events: events)
            }
        }
    }
    
    func mapToPortrait(events: [Event]) -> [Portrait] {
        return events.map{(item: Event) -> Portrait in
            return Portrait(events: item)
        }
    }
    
    override init() {
        super.init()
        fetchEvents()
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        let width = Double(collectionContext!.containerSize.width)
        let height = EmbeddedCollectionCell.height()
        return CGSize(width: width, height: height)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: EmbeddedCollectionCell.reuseIdentifier, bundle: Bundle.main, for: self, at: index) as! EmbeddedCollectionCell
        
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    func didUpdate(to object: Any) {
    
    }
    
    func didSelectItem(at index: Int) {

    }
    
}

extension EmbeddedSectionController: IGListAdapterDelegate {
    
    func listAdapter(_ listAdapter: IGListAdapter!, didEndDisplaying object: Any!, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, willDisplay object: Any!, at index: Int) {
        if self.events.count - 5 == index {
            fetchEvents()
        }
    }
}

extension EmbeddedSectionController: IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return self.events
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return PortraitSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}
