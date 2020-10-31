//
//  File.swift
//  BlendingArticle
//
//  Created by Riccardo Cipolleschi on 30/10/2020.
//

import Foundation
import UIKit

struct BlendViewCellVM {
  let imageName = "fire.jpg"
  let filterName: String

  init(filterName: String) {
    self.filterName = filterName
  }

  var uiImage: UIImage? {
    return UIImage(named: self.imageName)
  }
}

class BlendViewCell: UICollectionViewCell {

  static let reuseIdentifier = "\(BlendViewCell.self)"

  var model: BlendViewCellVM? {
    didSet {
      self.update(oldModel: oldValue)
    }
  }

  let backgroundImage = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.style()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  func setup() {
    self.contentView.addSubview(self.backgroundImage)
  }

  func style() {
    self.backgroundColor = .clear
    self.contentView.backgroundColor = .clear
  }

  func update(oldModel: BlendViewCellVM?) {
    guard let model = self.model else {
      self.backgroundImage.image = nil
      self.layer.compositingFilter = nil
      return
    }
    self.backgroundImage.image = model.uiImage
    self.layer.compositingFilter = model.filterName
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundImage.frame = CGRect(
      x: 0,
      y: 0,
      width: self.bounds.width,
      height: self.bounds.height - 20)
  }
}

