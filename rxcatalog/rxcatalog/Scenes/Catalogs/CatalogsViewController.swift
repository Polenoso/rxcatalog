//
//  CatalogsViewController.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

protocol CatalogsOutput : class {
    func displayCatalogs(catalogs: CatalogsModels.Output.Catalog.ViewModel)
}

class CatalogsViewController: UIViewController {
    
    var input: CatalogsInput?
    
    var displayedCatalogs: CatalogsModels.Output.Catalog.ViewModel = CatalogsModels.Output.Catalog.ViewModel.init(data: [])
    
    @IBOutlet var catalogsCollectionView: UICollectionView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        let viewModel = CatalogsViewModel(dataSource: CatalogApiProvider.build())
        let output = self
        input = viewModel
        viewModel.output = output
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        fetchData()
    }
    
    fileprivate func setupCollectionViews() {
        //Delegates and datasources are binded from Storyboard
        catalogsCollectionView.register(UINib.init(nibName: String(describing: CatalogsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: CatalogsCollectionViewCell.ReuseIdentifier)
        catalogsCollectionView.register(UINib.init(nibName: String(describing: CatalogSectionHeaderCollectionReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CatalogSectionHeaderCollectionReusableView.ReusableIdentifier)
        
        if let flowLayout = catalogsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    fileprivate func fetchData() {
        input?.fetchCatalogs()
    }
    
}

extension CatalogsViewController: CatalogsOutput {
    
    func displayCatalogs(catalogs: CatalogsModels.Output.Catalog.ViewModel) {
        displayedCatalogs = catalogs
        catalogsCollectionView.reloadData()
    }
    
}

extension CatalogsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedCatalogs.data.count > 0 ? displayedCatalogs.data[section].catalogs.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogsCollectionViewCell.ReuseIdentifier, for: indexPath) as! CatalogsCollectionViewCell
        cell.updateView(viewModel: displayedCatalogs.data[indexPath.section].catalogs[indexPath.item])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return displayedCatalogs.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
           let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CatalogSectionHeaderCollectionReusableView.ReusableIdentifier, for: indexPath) as! CatalogSectionHeaderCollectionReusableView
            view.updateUI(title: displayedCatalogs.data[indexPath.section].title)
            return view
        }
        return UICollectionReusableView()
    }
}

extension CatalogsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CatalogSectionHeaderCollectionReusableView.sizeForHeader(with: displayedCatalogs.data[section].title, in: collectionView.frame)
    }
    
    
}
