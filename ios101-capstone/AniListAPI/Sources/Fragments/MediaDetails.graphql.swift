// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct MediaDetails: AniListAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment MediaDetails on Media { __typename id title { __typename romaji english native } siteUrl coverImage { __typename extraLarge color } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { AniListAPI.Objects.Media }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Int.self),
    .field("title", Title?.self),
    .field("siteUrl", String?.self),
    .field("coverImage", CoverImage?.self),
  ] }

  /// The id of the media
  public var id: Int { __data["id"] }
  /// The official titles of the media in various languages
  public var title: Title? { __data["title"] }
  /// The url for the media page on the AniList website
  public var siteUrl: String? { __data["siteUrl"] }
  /// The cover images of the media
  public var coverImage: CoverImage? { __data["coverImage"] }

  /// Title
  ///
  /// Parent Type: `MediaTitle`
  public struct Title: AniListAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AniListAPI.Objects.MediaTitle }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("romaji", String?.self),
      .field("english", String?.self),
      .field("native", String?.self),
    ] }

    /// The romanization of the native language title
    public var romaji: String? { __data["romaji"] }
    /// The official english title
    public var english: String? { __data["english"] }
    /// Official title in it's native language
    public var native: String? { __data["native"] }
  }

  /// CoverImage
  ///
  /// Parent Type: `MediaCoverImage`
  public struct CoverImage: AniListAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { AniListAPI.Objects.MediaCoverImage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("extraLarge", String?.self),
      .field("color", String?.self),
    ] }

    /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
    public var extraLarge: String? { __data["extraLarge"] }
    /// Average #hex color of cover image
    public var color: String? { __data["color"] }
  }
}
