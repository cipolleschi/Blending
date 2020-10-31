//
//  BlendView.swift
//  BlendingArticle
//
//  Created by Riccardo Cipolleschi on 30/10/2020.
//

import Foundation
import UIKit

struct BlendModeVM {
  let blendModes: [String]
  let imageName: String

  init() {
    self.blendModes = CIFilter
          .filterNames(inCategory: nil)
          .filter { $0.contains("BlendMode")}
          .map {
            let capitalizedFilter = $0.dropFirst(2)
            let first = capitalizedFilter.first!
            return "\(first.lowercased())\(capitalizedFilter.dropFirst())"
          }
    self.imageName = "penguin.jpg"
  }

  var uiImage: UIImage? {
    return UIImage(named: self.imageName)
  }
}

class BlendModeView:
  UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  var model: BlendModeVM? {
    didSet {
      self.update(oldModel: oldValue)
    }
  }

  var userDidSelectFilter: ((String) -> ())?

  let backgroundImage = UIImageView()
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.backgroundView = self.backgroundImage
    collection.dataSource = self
    collection.delegate = self

    collection.showsVerticalScrollIndicator = false
    collection.showsHorizontalScrollIndicator = false

    collection.register(BlendViewCell.self, forCellWithReuseIdentifier: BlendViewCell.reuseIdentifier)

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
    self.addSubview(self.backgroundImage)
    self.addSubview(self.collectionView)
  }

  func style() {
    self.collectionView.backgroundColor = .clear
  }

  func update(oldModel: BlendModeVM?) {
    self.backgroundImage.image = model?.uiImage
    self.collectionView.reloadData()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundImage.frame = self.bounds
    self.collectionView.frame = self.bounds

  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.model?.blendModes.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlendViewCell.reuseIdentifier, for: indexPath) as! BlendViewCell
    cell.model = BlendViewCellVM(filterName: self.model?.blendModes[indexPath.row] ?? "")
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 200, height: 220)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let filter = model?.blendModes[indexPath.row] else {
      return
    }
    self.userDidSelectFilter?(filter)
  }
}

