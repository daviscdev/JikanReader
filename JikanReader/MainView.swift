//
//  MainView.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = TopRankViewModel()
    
    var body: some View {
        TabView {
            TopRankView()
                .environmentObject(viewModel)
                .tabItem {
                    Label("Top Rank", systemImage: "list.number")
                }

            FavoriteView()
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
