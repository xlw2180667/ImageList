//
//  ViewController.swift
//  ImageList
//
//  Created by Xie Liwei on 06/04/2019.
//  Copyright © 2019 Xie Liwei. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var imageOffsetSpeed: CGFloat = 50
    var cellHeight: CGFloat = 208

    var viewModel: ImageListViewModelProtocol!
    fileprivate let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        bindViewModle()
        setupTableView()
    }
    
    func bindViewModle() {
        viewModel = ImageListViewModel(provider: ImageListService())
        viewModel.fetchImageData()
        
        viewModel.datasource.bind { [weak self] _ in
            self?.tableView.reloadData()
        }.disposed(by: bag)
    }
    
    func updateUI() {
        view.backgroundColor = .black
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    var imageHeight: CGFloat {
        let maxOffset  = sqrt(pow(cellHeight, 2) + 4 * imageOffsetSpeed * tableView.frame.height - cellHeight) / 2
        return maxOffset + cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
        cell.imageHeight.constant = imageHeight
        cell.imageToTopConstraint.constant = newOffSet(newOffSetY: tableView.contentOffset.y, cell: cell)
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cellImageView = (cell as? ImageTableViewCell)?.cellImageView else { return }
        let image = viewModel.datasource.value[indexPath.row]
        let url = image.url
        let resource = ImageResource(downloadURL: url, cacheKey: "\(url.absoluteString)")
        cellImageView.kf.setImage(with: resource,
                                         placeholder: UIImage(named: "PlaceHolder"),
                                         options: [.processor(DownsamplingImageProcessor(size: CGSize(width: 450, height: 450))),
                                                   .cacheOriginalImage])
        CellAnimator.animateDropIn(cell: cell)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 238
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func newOffSet(newOffSetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        return (newOffSetY - cell.frame.origin.y) / imageHeight * imageOffsetSpeed
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cells = tableView.visibleCells as! [ImageTableViewCell]
        for cell in cells {
            cell.imageToTopConstraint.constant = newOffSet(newOffSetY: tableView.contentOffset.y, cell: cell)
        }
    }
}
