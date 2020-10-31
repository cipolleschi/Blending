//
//  CompositingVC.swift
//  BlendingArticle
//
//  Created by Riccardo Cipolleschi on 30/10/2020.
//

import Foundation
import UIKit

class CompositingVC: UIViewController {

  var rootView: CompositingView {
    return self.view as! CompositingView
  }

  override func loadView() {
    let view = CompositingView()
    view.model = CompositingVM()
    self.view = view
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.rootView.userDidSelectFilter = { [unowned self] filter in
      let actualFilter = filter == "Clear Filter" ? nil : filter
      let model = CompositingVM(selectedFilter: actualFilter)
      self.rootView.model = model
    }
  }

}
