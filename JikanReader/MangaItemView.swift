//
//  MangaItemView.swift
//  JikanReader
//
//  Created by rensakura on 2022/4/8.
//

import SwiftUI

struct MangaItemView: View {
    var item: Manga
    var showRank = true
    var body: some View {
        HStack {
            Text("\(Int(item.rank ?? 0))")
                .font(.system(size: 24))
                .opacity(showRank ? 1.0: 0.0)
            
            let url = URL(string: item.images?["jpg"]?.imageURL ?? "")!
            AsyncImage(
                url: url,
                content: { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: 80, maxHeight: 100)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            VStack(alignment: .leading) {
                Text("\(item.titleJapanese ?? "")")
                    .lineLimit(3)
                Text("Start:\(item.published?.from ?? "")")
                    .font(.system(size: 12))
                Text("End:\(item.published?.to ?? "To be continued")")
                    .font(.system(size: 12))
            }
        }
    }
}

struct MangaItemView_Previews: PreviewProvider {
    static var previews: some View {
        MangaItemView(item: Manga(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], title: "test", titleEnglish: "test", titleJapanese: "測試", titleSynonyms: nil, type: nil, chapters: nil, volumes: nil, status: nil, publishing: nil, published: nil, score: nil, scoredBy: nil, rank: 1.0, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, authors: nil, serializations: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil))
    }
}
