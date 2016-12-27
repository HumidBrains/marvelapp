//
//  newCharacterViewController.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import IGListKit

protocol Detailable {
    func showDetailsOf(character: Character)
}

enum SectionController {
    case grid
    case row
}

class newCharacterViewController: UIViewController, SearchSectionControllerDelegate {
    
    var apiManager: MarvelAPICalls = MarvelAPIManager()
    var views: [IGListDiffable] = []
    var characters: [Character] = []
    
    var filterString: String = ""
    
    lazy var searchView: Search = {
        return Search(delegate: self)
    }()
    
    func searchSectionController(_ sectionController: SearchSectionController, didChangeText text: String) {
        filterString = text
        adapter.performUpdates(animated: true, completion: nil)
    }

    let embeddedView: Embedded = Embedded()
    
    var sectionController: SectionController = .row
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    
    @IBOutlet weak var collectionView: IGListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        fetchCharacters()
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchCharacters(for query: String? = nil) {
        apiManager.characters(query: query, skip: self.characters.count) { characters in
            if let characters = characters {
                self.characters += characters
                self.views += self.mMapToView(characters: characters)
                self.adapter.performUpdates(animated: true, completion: nil)
            }
        }
    }
    
    func mMapToView(characters: [Character]) -> [IGListDiffable] {
        var items:[IGListDiffable] = []
        if characters.count > 0 {
            
            let filter: [IGListDiffable]
            
            filter = characters.map{ (item: Character) -> CharactableView in
                return CharactableView(character: item, sectionController: sectionController)
                } as [IGListDiffable]
            
            items.append(contentsOf: filter)
        }
        
        return items
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func showDetailsOf(character: Character) {
        guard let nextController = Storyboard.Main.characterViewControllerScene
            .viewController() as? CharacterViewController else {
                return
        }
        
        nextController.character = character
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

extension newCharacterViewController {
    @IBAction func showAsGrid(_ sender: UIButton) {
        sectionController = .grid
        self.views = self.mMapToView(characters: self.characters)
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    @IBAction func showAsTable(_ sender: UIButton) {
        sectionController = .row
        self.views = self.mMapToView(characters: self.characters)
        adapter.performUpdates(animated: true, completion: nil)
    }
}

extension newCharacterViewController: IGListAdapterDelegate {
    
    func listAdapter(_ listAdapter: IGListAdapter!, didEndDisplaying object: Any!, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, willDisplay object: Any!, at index: Int) {
        if self.characters.count - 5 == index {
            fetchCharacters()
        }
    }
}

extension newCharacterViewController: IGListAdapterDataSource {
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        
        guard filterString != "" else {
            return [self.searchView as IGListDiffable] + [self.embeddedView] + self.views
        }
        
        let filter = self.views.flatMap({ (item) -> CharactableView? in
            guard let item = item as? CharactableView else {
                return nil
            }
            
            return item
        }).filter { (item) -> Bool in
            item.character.name.lowercased().contains(self.filterString.lowercased())
        }
            
        return [self.searchView as IGListDiffable] + [self.embeddedView] + (filter as [IGListDiffable])
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        
        if let object = object as? SectionControllerProtocol {
            return object.sectionController()
        }
        
        return IGListSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
}
