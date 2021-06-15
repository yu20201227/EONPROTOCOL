
import Foundation

protocol AnyUsecase {
    var presenter: AnyPresenter? { get set }
    func fetchData(_ data: Result<[Model], Error>) -> Error
}

class UserInteractor: AnyUsecase {
    static let shared: UserInteractor = UserInteractor.factory()
    
    static func factory() -> UserInteractor {
        return UserInteractor(presenter: UserPresenter.shared)
    }

    var presenter: AnyPresenter?
    
    init(presenter: AnyPresenter) {
        self.presenter = presenter
    }
        
    func fetchData(_ data: Result<[Model], Error>) -> Error {
        switch data {
        case .success(let model):
            self.presenter?.receiveDataFromInteractor(data)
        case .failure:
            break
        }
        return fatalError()
    }

    
}
