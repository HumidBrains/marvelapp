/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.
 
 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import IGListKit

protocol SearchSectionControllerDelegate: class {
    func searchSectionController(_ sectionController: SearchSectionController, didChangeText text: String)
}

final class SearchSectionController: IGListSectionController, IGListSectionType, UISearchBarDelegate, IGListScrollDelegate {
    
    weak var delegate: SearchSectionControllerDelegate?
    
    override init() {
        super.init()
        scrollDelegate = self
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: SearchCollectionCell.height())
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: SearchCollectionCell.reuseIdentifier, bundle: Bundle.main, for: self, at: index) as! SearchCollectionCell
        cell.searchBar.delegate = self
        return cell
    }
    
    func didUpdate(to object: Any) {}
    func didSelectItem(at index: Int) {}
    
    //MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchSectionController(self, didChangeText: searchText)
    }
    
    //MARK: IGListScrollDelegate
    
    func listAdapter(_ listAdapter: IGListAdapter, didScroll sectionController: IGListSectionController) {
        if let searchBar = (collectionContext?.cellForItem(at: 0, sectionController: self) as? SearchCollectionCell)?.searchBar {
            searchBar.text = ""
            searchBar.resignFirstResponder()
        }
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, willBeginDragging sectionController: IGListSectionController!) {}
    func listAdapter(_ listAdapter: IGListAdapter!, didEndDragging sectionController: IGListSectionController!, willDecelerate decelerate: Bool) {}
    
}
