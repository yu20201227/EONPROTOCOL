

import Foundation

enum ErrorCase: Error {
    case failed
}

protocol AnyPresenter {
    var view: AnyView? { get set }
    var interactor: AnyUsecase? { get set }
    
    func receiveDataFromInteractor(_ data: Result<[Model], Error>) -> Error
}

class UserPresenter: AnyPresenter {
    static let shared: UserPresenter = UserPresenter.factory()
    
    static func factory() -> UserPresenter {
        return UserPresenter(view: UserViewController.shared,
                             interactor: UserInteractor.shared)
    }
    
    var view: AnyView?
    var interactor: AnyUsecase?
    
    init(view: AnyView, interactor: AnyUsecase) {
        self.view = view
        self.interactor = interactor
    }
    
    
    
    func receiveDataFromInteractor(_ data: Result<[Model], Error>) -> Error {
        switch data {
        case .success(let data):
            self.view?.updateView(with: data)
        case .failure:
            self.view?.failedUpdateView(with: ErrorCase.failed)
        }
        return fatalError()
    }
    
    
}
