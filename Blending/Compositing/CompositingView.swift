//
//  CompositingView.swift
//  BlendingArticle
//
//  Created by Riccardo Cipolleschi on 30/10/2020.
//

import Foundation
import UIKit

struct CompositingVM {
  let compositingModes: [String]
  let imageLeftName: String
  let imageRightName: String
  let selectedFilter: String?

  init(selectedFilter: String? = nil) {
    self.compositingModes = CIFilter
      .filterNames(inCategory: nil)
      .filter { $0.contains("Compositing")}
      .map {
        let capitalizedFilter = $0.dropFirst(2)
        let first = capitalizedFilter.first!
        return "\(first.lowercased())\(capitalizedFilter.dropFirst().dropLast("Compositing".count))"
      } + ["Clear Filter"]
    
    self.imageLeftName = "dawn.jpg"
    self.imageRightName = "mountain.jpg"
    self.selectedFilter = selectedFilter
  }

  var leftUIImage: UIImage? {
    return UIImage(named: self.imageLeftName)
  }

  var rightUIImage: UIImage? {
    return UIImage(named: self.imageRightName)
  }
}

class CompositingView:
  UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  var model: CompositingVM? {
    didSet {
      self.update(oldModel: oldValue)
    }
  }

  var userDidSelectFilter: ((String) -> ())?

  let leftImage = UIImageView()
  let rightImage = UIImageView()

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.dataSource = self
    collection.delegate = self

    collection.showsVerticalScrollIndicator = false
    collection.showsHorizontalScrollIndicator = false

    collection.register(CompositingCell.self, forCellWithReuseIdentifier: CompositingCell.reuseIdentifier)

    return collection
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.style()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  func setup() {
    self.addSubview(self.leftImage)
    self.addSubview(self.rightImage)
    self.addSubview(self.collectionView)
  }

  func style() {
    self.collectionView.backgroundColor = .white
  }

  func update(oldModel: CompositingVM?) {
    self.leftImage.image = model?.leftUIImage
    self.rightImage.image = model?.rightUIImage
    self.rightImage.layer.compositingFilter = model?.selectedFilter
    self.collectionView.reloadData()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.leftImage.frame = CGRect(
      x: 0,
      y: 0,
      width: self.bounds.width * 3 / 4,
      height: self.bounds.height / 2
    )
    self.rightImage.frame = CGRect(
      x: self.bounds.width / 4,
      y: 0,
      width: self.bounds.width * 3 / 4,
      height: self.bounds.height / 2
    )
    self.collectionView.frame = CGRect(
      x: 0,
      y: self.bounds.height / 2,
      width: self.bounds.width,
      height: self.bounds.height / 2
    )

  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.model?.compositingModes.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompositingCell.reuseIdentifier, for: indexPath) as! CompositingCell
    cell.model = CompositingCellVM(filterName: self.model?.compositingModes[indexPath.row] ?? "")
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 20)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let filter = model?.compositingModes[indexPath.row] else {
      return
    }
    self.userDidSelectFilter?(filter)
  }
}


