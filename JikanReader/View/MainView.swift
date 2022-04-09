//
//  MainView.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = TopRankViewModel()
    @StateObject var favoriteViewModel = FavoriteViewModel()
    
    var body: some View {
        TabView {
            TopRankView()
                .environmentObject(viewModel)
                .environmentObject(favoriteViewModel)
                .tabItem {
                    Label("Top Rank", systemImage: "list.number")
                }

            FavoriteView()
                .environmentObject(favoriteViewModel)
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
