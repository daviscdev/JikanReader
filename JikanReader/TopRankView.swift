//
//  TopRankView.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import SwiftUI

struct TopRankView: View {
    @EnvironmentObject private var viewModel: TopRankViewModel
    
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
                    
                    HStack {
                        Spacer()
                        
                        if viewModel.typeSelection == 0 {
                            animeTypePicker
                                .padding(.horizontal)
                        }
                        else {
                            mangaTypePicker
                                .padding(.horizontal)
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
    }
    
    var animeTypePicker: some View {
        Picker("AnimeType", selection: $viewModel.animeTypeSelection) {
            ForEach(0..<viewModel.animeType.count, id:\.self) {
                Text(viewModel.animeType[$0])
            }
        }
        .onChange(of: viewModel.animeTypeSelection) { tag in
            viewModel.selectAnimeType(type: viewModel.animeType[tag])
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
            viewModel.selectMangaType(type: viewModel.mangaType[tag])
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
                        withAnimation {
                            //viewModel.toggleFavorite(itemID: item.id)
                        }
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
                        withAnimation {
                            //viewModel.toggleFavorite(itemID: item.id)
                        }
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopRankView()
            .environmentObject(TopRankViewModel())
    }
}
