//
//  CatViewModel.swift
//  CatApp
//
//  Created by mai nguyen on 6/22/23.
//

import Foundation


class CatViewModel {
    let apiService = APIService()
    var catResponses : [CatModel]? = nil
    
    func getListOfCatS(completion: @escaping ([CatModel]?) -> Void) {
        self.apiService.fetchData(client: CatEndpoint.search) { [weak self] (catResponses: [CatModel]?) in
            self?.catResponses = catResponses
            completion(catResponses)
        }
    }
    
    func numberOfCats() -> Int {
        return catResponses?.count ?? 0
    }
}
