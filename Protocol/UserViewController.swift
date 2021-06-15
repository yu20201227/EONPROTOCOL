
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func updateView(with success: [Model])
    func failedUpdateView(with error: Error) -> Error
}

class UserViewController: AnyView {
    static let shared: UserViewController = UserViewController.factory()
    
    static func factory() -> UserViewController {
        return UserViewController(presenter: UserPresenter.shared)
    }
    
    var presenter: AnyPresenter?
    
    init(presenter: AnyPresenter) {
        self.presenter = presenter
    }
    
    @IBOutlet weak var label: UILabel!

    
    func updateView(with success: [Model]) {
        self.label.text = success.description
    }
    
    func failedUpdateView(with error: Error) -> Error {
        return fatalError()
    }
    
    
}
