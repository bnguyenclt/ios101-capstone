//
//  NetworkManager.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/13/25.
//  Uses AniList API, which requires GraphQL requests.  https://docs.anilist.co/guide/graphql/
//  Uses Apollo iOS Client to fetch GraphQL requests.   https://www.apollographql.com/docs/ios
//

import Foundation
import Apollo
import ApolloSQLite
import AniListAPI

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://graphql.anilist.co"
    
    // MARK: Apollo using InMemoryNormalizedCache strategy
    //       Writes cache directly to system memory. Reads and writes records faster.
    private(set) lazy var apollo = ApolloClient(url: URL(string: baseURL)!)
    
    // MARK: Apollo using SQLiteCache strategy
    //       Writes cache to on-disk SQLite file. Maintains cache between application runs.
    private(set) lazy var apolloSQLite: ApolloClient = {
        do {
            let documentsPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentsPath.appendingPathComponent("apollo_cache.sqlite")
            let sqliteCache = try SQLiteNormalizedCache(fileURL: fileUrl)
            let store = ApolloStore(cache: sqliteCache)
            let normalTransport: RequestChainNetworkTransport = RequestChainNetworkTransport(interceptorProvider: DefaultInterceptorProvider(store: store), endpointURL: URL(string: baseURL)!)
            return ApolloClient(networkTransport: normalTransport, store: store)
        } catch {
            print("Error creating ApolloSQLite Client: \(error)")
            return apollo
        }
    }()
    
    private init() {}
    
    //  MARK: - Network client functions
    //  Uses SQLite to return cache data, or else fetch
    func getMedia(for id: Int, completed: @escaping (Result<MediaByIDQuery.Data.Media, MediaError>) -> Void) {
        let nullableID: GraphQLNullable<Int> = GraphQLNullable(integerLiteral: id)
        
        apolloSQLite.fetch(query: MediaByIDQuery(id: nullableID),
                     cachePolicy: .returnCacheDataElseFetch
        ) { result in
            switch result {
            case .success(let graphQLResult):
                let media = graphQLResult.data?.media
                completed(.success(media!))
                return
            case .failure(let error):
                print("Failure! Error: \(error)")
                completed(.failure(.mediaNotFound))
            }
        }
    }
    
    //  Uses SQLite to return cache only (for persisted queries).
    func getMediaWithinCache(for id: Int, completed: @escaping (Result<MediaByIDQuery.Data.Media, MediaError>) -> Void) {
        let nullableID: GraphQLNullable<Int> = GraphQLNullable(integerLiteral: id)
        
        apolloSQLite.fetch(query: MediaByIDQuery(id: nullableID),
                     cachePolicy: .returnCacheDataDontFetch
        ) { result in
            switch result {
            case .success(let graphQLResult):
                let media = graphQLResult.data?.media
                completed(.success(media!))
                return
            case .failure(let error):
                print("Failure! Error: \(error)")
                completed(.failure(.mediaNotFound))
            }
        }
    }
    
    
    func getPage(id: Int?, page: Int, perPage: Int, search: String?,
                 completed: @ escaping (Result<PaginationQuery.Data.Page, MediaError>) -> Void) {
        let nullableSearch: GraphQLNullable<String> = GraphQLNullable(stringLiteral: search ?? "")
        
        apollo.fetch(query: PaginationQuery(id: id ?? nil, page: page, perPage: 30, search: nullableSearch),
                     cachePolicy: .returnCacheDataElseFetch
        ) { result in
            switch result {
            case .success(let graphQLResult):
                let pageData = graphQLResult.data?.page
                completed(.success(pageData!))
                return
            case .failure(let error):
                print("Failure! Error: \(error)")
                completed(.failure(.pageNotFound))
            }
        }
    }

    
}
