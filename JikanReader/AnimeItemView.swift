//
//  AnimeItemView.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import SwiftUI

struct AnimeItemView: View {
    var item: Anime
    var body: some View {
        HStack {
            Text("\(Int(item.rank!))")
                .font(.system(size: 24))
            
            let url = URL(string: item.images?["jpg"]?.imageURL ?? "")!
            AsyncImage(
                url: url,
                content: { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: 100, maxHeight: 100)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            VStack(alignment: .leading) {
                Text("\(item.titleJapanese ?? "")")
                    .lineLimit(3)
                Text("Start:\(item.aired?.from ?? "")")
                    .font(.system(size: 12))
                Text("End:\(item.aired?.to ?? "To be continued")")
                    .font(.system(size: 12))
            }
        }
    }
}

struct AnimeItemView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeItemView(item: Anime(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], trailer: nil, title: "test", titleEnglish: "test", titleJapanese: "測試", titleSynonyms: nil, type: nil, source: nil, episodes: nil, status: nil, airing: nil, aired: nil, duration: nil, rating: nil, score: 5.0, scoredBy: nil, rank: 1.0, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, season: nil, year: nil, broadcast: nil, producers: nil, licensors: nil, studios: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil))
    }
}
