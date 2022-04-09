//
//  FavoriteView.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject private var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteViewModel.favoriteList, id: \.id)  { item in
                    NavigationLink {
                        if let urlString = item.url, let url = URL(string: urlString) {
                            WebView(url: url)
                        }
                    } label: {
                        switch item.metadata {
                        case let .anime(aired):
                            AnimeItemView(item: Anime(id: item.id, url: item.url, images: item.images, trailer: nil, title: item.title, titleEnglish: item.titleEnglish, titleJapanese: item.titleJapanese, titleSynonyms: nil, type: nil, source: nil, episodes: nil, status: nil, airing: nil, aired: aired, duration: nil, rating: nil, score: nil, scoredBy: nil, rank: nil, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, season: nil, year: nil, broadcast: nil, producers: nil, licensors: nil, studios: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil), showRank: false)
                        case let .manga(published):
                            MangaItemView(item: Manga(id: item.id, url: item.url, images: item.images, title: item.title, titleEnglish: item.titleEnglish, titleJapanese: item.titleJapanese, titleSynonyms: nil, type: nil, chapters: nil, volumes: nil, status: nil, publishing: nil, published: published, score: nil, scoredBy: nil, rank: nil, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, authors: nil, serializations: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil), showRank: false)
                        }
                    }
                    .swipeActions {
                        Button {
                            favoriteViewModel.remove(item)
                        } label: {
                            Label {
                                Text("Remove")
                            } icon: {
                                Image(systemName: "heart.slash")
                            }
                        }
                        .tint(.pink)
                    }
                }
            }
            .navigationTitle("Favorite")
            .listStyle(PlainListStyle())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
