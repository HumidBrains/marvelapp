//
//  newCharacterViewController.swift
//  Marvel
//
//  Created by Rodrigo Cavalcante on 15/12/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import IGListKit

class tableCharacterViewController: UIViewController {
    
    @IBOutlet weak var collectionView: IGListCollectionView!
    
    var apiManager: MarvelAPICalls = MarvelAPIManager()
    var characters: [Character] = []
    
    lazy var adapter: IGListAdapter = {
        //TALK: IGListAdapterUpdater is a concrete that implements IGListUpdatingDelegate (handle section and row update events)
        // 'least-minimal diff' to update UI
        // The working range is the number of objects beyond the visible objects (plus and minus) that should be notified when they are close to being visible
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        fetchCharacters()
        
        //TALK: define adapters collectionView and dataSource
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    @IBAction func changeObject() {
        let c = Character()
        self.characters[0] = c
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    func fetchCharacters(for query: String? = nil) {
        apiManager.characters(query: query, skip: self.characters.count) { characters in
            if let characters = characters {
                self.characters += characters
                self.adapter.performUpdates(animated: true)
            }
        }
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

//TALK: like UITableViewDataSource
extension tableCharacterViewController: IGListAdapterDataSource {
    
    //TALK: like numberOfRowsInSection
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return self.characters
    }
    
    //TALK: SectionController for object
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return TableSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
}
