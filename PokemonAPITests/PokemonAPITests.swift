//
//  PokemonAPITests.swift
//  PokemonAPITests
//
//  Created by Samlo Berutu on 27/02/23.
//

import XCTest
@testable import PokemonAPI

final class PokemonAPITests: XCTestCase {
    let pkmListVM = Injection.init().provideHomeView()
    
    func checkGetPKMListEndpoint() {
        let endPoint = FetchPokemonEndpoint(pokemonEndpoint: .getPKMList(offset: 30, limit: 30))
        XCTAssertEqual(endPoint.host, "pokeapi.co", "The host should be pokeapi.co")
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
