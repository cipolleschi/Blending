//
//  CompositingCell.swift
//  BlendingArticle
//
//  Created by Riccardo Cipolleschi on 30/10/2020.
//

import Foundation
import UIKit

struct CompositingCellVM {
  let filterName: String

  init(filterName: String) {
    self.filterName = filterName
  }


}

class CompositingCell: UICollectionViewCell {

  static let reuseIdentifier = "\(CompositingCell.self)"

  var model: CompositingCellVM? {
    didSet {
      self.update(oldModel: oldValue)
    }
  }

  let filterNameLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.style()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  func setup() {
    self.contentView.addSubview(self.filterNameLabel)
  }

  func style() {
    self.backgroundColor = .clear
    self.contentView.backgroundColor = .clear
    self.filterNameLabel.textAlignment = .center
    self.filterNameLabel.numberOfLines = 0
  }

  func update(oldModel: CompositingCellVM?) {
    guard let model = self.model else {
      return
    }
    self.filterNameLabel.text = model.filterName
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.filterNameLabel.frame = self.bounds
  }
}


