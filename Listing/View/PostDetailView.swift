//
//  ListingApp.swift
//  Listing
//
//  Created by roma singh on 02/10/25.
//

import SwiftUI

struct PostDetailView: View {
    @ObservedObject var viewModel: PostsViewModel
    let post: Post
    let sourceTitle: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(post.title)
                .font(.title)
                .bold()

            Text(post.body)
                .font(.body)

            Spacer()

            Button(action: {
                viewModel.toggleFavorite(post: post)
            }) {
                Image(systemName: viewModel.isFavorite(post: post) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .padding(.bottom, 30)
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text(sourceTitle)
                    }
                    .foregroundColor(.green)
                    .font(.headline)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .background(Color.white.ignoresSafeArea())
    }
}
