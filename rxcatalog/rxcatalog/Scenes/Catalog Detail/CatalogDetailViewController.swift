//
//  CatalogDetailViewController.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

protocol CatalogDetailOutput: class {
    func displayDetail(_ detail: CatalogDetailModels.Output.ViewModel.Displayed)
}

class CatalogDetailViewController: UIViewController {
    
    var input: CatalogDetailInput?
    var navigator: (CatalogDetailNavigator & CatalogDetailDataPassing)?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var retailerLabel: UILabel!
    @IBOutlet var couponDescriptionLabel: UILabel!
    
    var displayedData: [(title: String?, description:String?)] = []
    
    var tableHeaderView: UILabel?
    
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        let viewModel = CatalogDetailViewModel()
        let output = self
        let nav = CatalogDetailNavigatorMain()
        output.navigator = nav
        viewModel.output = output
        nav.dataStore = viewModel
        input = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 65
        tableView.tableFooterView = UIView()
        tableHeaderView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 65))
        tableView.tableHeaderView = tableHeaderView
    }
    
    private func fetchData() {
        input?.fetch()
    }

}

extension CatalogDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NearestStoreTableViewCell.ReuseIdentifer, for: indexPath) as! NearestStoreTableViewCell
        
        cell.updateUI(data: displayedData[indexPath.row])
        
        return cell
    }
    
    
}

extension CatalogDetailViewController: CatalogDetailOutput {
    func displayDetail(_ detail: CatalogDetailModels.Output.ViewModel.Displayed) {
        retailerLabel.text = detail.retailerName
        couponDescriptionLabel.text = detail.couponDescription
        couponDescriptionLabel.isHidden = !detail.isCoupon
        displayedData = detail.storeData
        tableHeaderView?.text = detail.storeTitle
        tableView.reloadData()
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
}
