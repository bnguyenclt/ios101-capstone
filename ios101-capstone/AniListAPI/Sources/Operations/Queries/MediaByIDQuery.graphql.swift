// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class MediaByIDQuery: GraphQLQuery {
  public static let operationName: String = "MediaByID"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query MediaByID($id: Int) { Media(id: $id) { __typename ...MediaDetails description season seasonYear episodes genres averageScore popularity } }"#,
      fragments: [MediaDetails.self]
    ))

  public var id: GraphQLNullable<Int>

  public init(id: GraphQLNullable<Int>) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AniListAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AniListAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Media", Media?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Media query
    public var media: Media? { __data["Media"] }

    /// Media
    ///
    /// Parent Type: `Media`
    public struct Media: AniListAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { AniListAPI.Objects.Media }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("description", String?.self),
        .field("season", GraphQLEnum<AniListAPI.MediaSeason>?.self),
        .field("seasonYear", Int?.self),
        .field("episodes", Int?.self),
        .field("genres", [String?]?.self),
        .field("averageScore", Int?.self),
        .field("popularity", Int?.self),
        .fragment(MediaDetails.self),
      ] }

      /// Short description of the media's story and characters
      public var description: String? { __data["description"] }
      /// The season the media was initially released in
      public var season: GraphQLEnum<AniListAPI.MediaSeason>? { __data["season"] }
      /// The season year the media was initially released in
      public var seasonYear: Int? { __data["seasonYear"] }
      /// The amount of episodes the anime has when complete
      public var episodes: Int? { __data["episodes"] }
      /// The genres of the media
      public var genres: [String?]? { __data["genres"] }
      /// A weighted average score of all the user's scores of the media
      public var averageScore: Int? { __data["averageScore"] }
      /// The number of users with the media on their list
      public var popularity: Int? { __data["popularity"] }
      /// The id of the media
      public var id: Int { __data["id"] }
      /// The official titles of the media in various languages
      public var title: MediaDetails.Title? { __data["title"] }
      /// The url for the media page on the AniList website
      public var siteUrl: String? { __data["siteUrl"] }
      /// The cover images of the media
      public var coverImage: MediaDetails.CoverImage? { __data["coverImage"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var mediaDetails: MediaDetails { _toFragment() }
      }
    }
  }
}
