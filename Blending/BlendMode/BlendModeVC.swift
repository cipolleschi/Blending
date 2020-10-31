//
//  BlendModeVC.swift
//  BlendingArticle
//
//  Created by Riccardo Cipolleschi on 30/10/2020.
//

import Foundation
import UIKit

class BlendModeVC: UIViewController {

  override func loadView() {
    let view = BlendModeView()
    view.model = BlendModeVM()
    self.view = view
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    (self.view as! BlendModeView).userDidSelectFilter = { [unowned self] filter in
      let alertController = UIAlertController(title: filter, message: nil, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
      self.present(alertController, animated: true, completion: nil)
    }
  }
}
