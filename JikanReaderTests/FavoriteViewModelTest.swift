//
//  FavoriteViewModelTest.swift
//  JikanReaderTests
//
//  Created by rensakura on 2022/4/9.
//

import XCTest
@testable import JikanReader

class FavoriteViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        UserDefaults.standard.removeObject(forKey: "favoriteList")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdd() {
        let favoriteItem = FavoriteItem(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], title: "test", titleEnglish: "test", titleJapanese: "測試", type: nil, metadata: .anime(aired: Aired(from: "2021", to: "2022", prop: nil)))
                
        let viewModel = FavoriteViewModel()
        viewModel.add(favoriteItem)
        
        XCTAssertTrue(viewModel.favoriteList.contains(favoriteItem))
        
        if let favoriteList = UserDefaults.standard.object(forKey: "favoriteList") as? Data {
            if let decodedFavoriteList = try? JSONDecoder().decode([FavoriteItem].self, from: favoriteList) {
                XCTAssertTrue(decodedFavoriteList.contains(favoriteItem))
            }
            else {
                XCTFail()
            }
        }
        else {
            XCTFail()
        }
    }

    func testAddDuplicate() {
        let favoriteItem = FavoriteItem(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], title: "test", titleEnglish: "test", titleJapanese: "測試", type: nil, metadata: .anime(aired: Aired(from: "2021", to: "2022", prop: nil)))
                
        let viewModel = FavoriteViewModel()
        viewModel.add(favoriteItem)
        viewModel.add(favoriteItem)
        viewModel.add(favoriteItem)
        
        XCTAssertTrue(viewModel.favoriteList.contains(favoriteItem))
        XCTAssertTrue(viewModel.favoriteList.count == 1)
    }
    
    func testRemove() {
        let favoriteItem = FavoriteItem(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], title: "test", titleEnglish: "test", titleJapanese: "測試", type: nil, metadata: .anime(aired: Aired(from: "2021", to: "2022", prop: nil)))
                
        let viewModel = FavoriteViewModel()
        viewModel.add(favoriteItem)
        viewModel.remove(favoriteItem)
        
        XCTAssertFalse(viewModel.favoriteList.contains(favoriteItem))
        
        if let favoriteList = UserDefaults.standard.object(forKey: "favoriteList") as? Data {
            if let decodedFavoriteList = try? JSONDecoder().decode([FavoriteItem].self, from: favoriteList) {
                XCTAssertFalse(decodedFavoriteList.contains(favoriteItem))
            }
            else {
                XCTFail()
            }
        }
        else {
            XCTFail()
        }
    }
}
