//
//  TopRankView.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import SwiftUI

struct TopRankView: View {
    @EnvironmentObject private var viewModel: TopRankViewModel
    @EnvironmentObject private var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Picker("Type", selection: $viewModel.typeSelection) {
                        ForEach(0..<viewModel.listType.count, id:\.self) {
                            Text(viewModel.listType[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    HStack(spacing: 0.0) {
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal.decrease.circle")
                        
                        if viewModel.typeSelection == 0 {
                            animeTypePicker
                                .padding(.leading, 8)
                                .padding(.trailing)
                        }
                        else {
                            mangaTypePicker
                                .padding(.leading, 8)
                                .padding(.trailing)
                        }
                    }
                    
                    if viewModel.typeSelection == 0 {
                        animeList
                    }
                    else {
                        mangaList
                    }
                }
                .navigationTitle("Top Ranking")
                .refreshable {
                    viewModel.refreshCurrentList()
                }
                .onAppear() {
                    viewModel.initTopRankList()
                }
                
                ProgressView()
                    .opacity(viewModel.isLoading ? 1.0: 0.0)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var animeTypePicker: some View {
        Picker("AnimeType", selection: $viewModel.animeTypeSelection) {
            ForEach(0..<viewModel.animeType.count, id:\.self) {
                Text(viewModel.animeType[$0])
            }
        }
        .onChange(of: viewModel.animeTypeSelection) { tag in
            viewModel.selectAnimeType(viewModel.animeType[tag])
        }
        .pickerStyle(.menu)
    }
    
    var mangaTypePicker: some View {
        Picker("MangaType", selection: $viewModel.mangaTypeSelection) {
            ForEach(0..<viewModel.mangaType.count, id:\.self) {
                Text(viewModel.mangaType[$0])
            }
        }
        .onChange(of: viewModel.mangaTypeSelection) { tag in
            viewModel.selectMangaType(viewModel.mangaType[tag])
        }
        .pickerStyle(.menu)
    }
    
    var animeList: some View {
        List {
            ForEach(viewModel.topAnimeList, id: \.id)  { item in
                NavigationLink {
                    if let urlString = item.url, let url = URL(string: urlString) {
                        WebView(url: url)
                    }
                } label: {
                    AnimeItemView(item: item)
                }
                .swipeActions {
                    Button {
                        let favoriteItem = FavoriteItem(id: item.id, url: item.url, images: item.images, title: item.title, titleEnglish: item.titleEnglish, titleJapanese: item.titleJapanese, metadata: .anime(aired: item.aired!))
                        favoriteViewModel.add(favoriteItem)
                    } label: {
                        Label {
                            Text("Favorite")
                        } icon: {
                            Image(systemName: "heart")
                        }
                    }
                    .tint(.pink)
                }
                .onAppear() {
                    if (viewModel.topAnimeList.last == item) {
                        viewModel.fetchNextAnimePage()
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    var mangaList: some View {
        List {
            ForEach(viewModel.topMangaList, id: \.id)  { item in
                NavigationLink {
                    if let urlString = item.url, let url = URL(string: urlString) {
                        WebView(url: url)
                    }
                } label: {
                    MangaItemView(item: item)
                }
                .swipeActions {
                    Button {
                        let favoriteItem = FavoriteItem(id: item.id, url: item.url, images: item.images, title: item.title, titleEnglish: item.titleEnglish, titleJapanese: item.titleJapanese, metadata: .manga(published: item.published!))
                        favoriteViewModel.add(favoriteItem)
                    } label: {
                        Label {
                            Text("Favorite")
                        } icon: {
                            Image(systemName: "heart")
                        }
                    }
                    .tint(.pink)
                }
                .onAppear() {
                    if (viewModel.topMangaList.last == item) {
                        viewModel.fetchNextMangaPage()
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopRankView()
            .environmentObject(TopRankViewModel())
    }
}
