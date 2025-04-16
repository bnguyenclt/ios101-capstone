# AnimeAngel

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

An anime ranking app that ranks anime by ratings and lets you save favorite anime.

### App Evaluation

- **Category:** Entertainment
- **Mobile:** The app can be useful as a mobile app, as it may send push notifications of anime news and can store favorite anime listings locally.
- **Story:** The story behind the app would be frustration with the UI of other anime ranking apps. Many users have experienced frustrations with similar apps and would be attrated to this one.
- **Market:** The market for the app would be well established, with similar apps existing and a demand for anime ranking apps existing already.
- **Habit:** The app would form habits through allowing users to browse and save anime listings.
- **Scope:** The fundamental features (browsing anime by rank, search and filters, save to favorites) would be simple to implement, but additional features may be added such as news notification or notifications for recently released anime as well as user profiles.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users will search for animes by name.
* Users may sort anime listings by ranking (highest to lowest).
* Users should be able to view details of the anime when entry is expanded.
* Users should be able to follow links to the anime's listing on AniList.
* Users may save specific listings in their favorites tab to find later.

**Optional Nice-to-have Stories**

* Users will be able to use certain filters when searching (studio, release date, genre, etc.).
* Users will be able to browser a list of results returned after submitting a search query.
* Users may be able to create an account with their email.
* Users may turn on push notifications to be notified of anime news.
* Users may link their AniList account to the app.

### 2. Screen Archetypes

- [ ] Search
    * Users will search for animes by names and certain filters (studio, release date, genre, etc.).
    * Users may sort anime listings by ranking (highest to lowest).
- [ ] Results Feed
    * Users will be able to browser a list of results returned after submitting a search query.
- [ ] Detail
    * Users should be able to view details of the anime when entry is expanded.
    * Users should be able to follow links to the anime's listing on AniList.
- [ ] Favorites
    * Users may save specific listings in their favorites tab to find later.
- [ ] Settings (optional features)
    * Users may be able to create an account with their email.
    * Users may turn on push notifications to be notified of anime news.
    * Users may link their AniList account to the app.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Search / Results Feed
* Favorites
* Settings

**Flow Navigation** (Screen to Screen)

- [ ]  Search / Results Feed
    * => Advanced filters
    * => Details
        * => AniList website link
- [ ] Favorites
    * => Details
        * => AniList website link
- [ ] Settings *(not implemented)*
    * => Account creation
    * => Notifications
    * => AniList account

## Wireframes

<img src="https://i.postimg.cc/SKPdWtS5/ios101-capstone-sketch-wireframe.png" width=600>

### [BONUS] Digital Wireframes & Mockups / Interactive Prototype

https://www.figma.com/design/ZGvtoio6Gxs3O4shnlMtyi/ios101-capstone-interactive-prototype?node-id=0-1&t=f65Fp8d09FpgBEV8-1

# Schema 

### Models

| Model           | Fields        | Type             | Description
| --------        | --------      | --------         | --------
| Media           | coverImage    | MediaCoverImage  | Object containing the cover image of the media.
|                 | title         | MediaTitle       | Object containing the media's title in Romaji, Japanese, and English.
|                 | id            | Int              | AniList ID of the media.
|                 | description   | String           | Description of the media.
|                 | season        | Enum             | Season of the media's release (spring, summer, fall, winter).
|                 | seasonYear    | Int              | Year of the anime's release.
|                 | episodes      | Int              | Number of episodes in anime.
|                 | averageScore  | Int              | Average score of the anime out of 100.
|                 | popularity    | Int              | Number of AniList users who favorited this anime.
|                 | siteURL       | String           | URL link to AniList entry for the media.
|                 | genres        | [String]         | Array of genres for the media.
| MediaCoverImage | extraLarge    | String           | URL link to an extra large version of the cover image.
|                 | color         | String           | Hex code of the average color of the cover image.
| MediaTitle      | romaji        | String           | Title of media in Romaji.
|                 | native        | String           | Title of media in Japanese.
|                 | english       | String           | Title of media in English.
| Page            | pageInfo      | PageInfo         | Object containing pagination information.
|                 | media         | [Media]          | Array of Media objects that match the pagination query.
| PageInfo        | currentPage   | Int              | Index of the current page.
|                 | hasNextPage   | Boolean          | Whether or not another page exists for this query.
|                 | perPage       | Int              | Number of items loaded per page.

### Networking

FetchMediaByID is called by MediaDetails and Favorites views. Pagination is called by Search view.

| Query          | Fields   | Type     | Description
| --------       | -------- | -------- | -------- 
| FetchMediaByID | id       | Int      | AniList ID of the media to search for.
| Pagination     | page     | Int!     | Index of the current page.
|                | perPage  | Int!     | Number of items loaded per page.
|                | id       | Int      | AniList ID of the media to search for.
|                | search   | String   | Term to look for within media.


### GraphQL
- Endpoint: https://graphql.anilist.co
- Pagination query
    - Variables
        - `'id': Int` *optional value*
        - `'page': Int!`
        - `'perPage': Int!`
        - `'search': String` *optional value*
    - Query
        - `query Pagination ($id: Int, $page: Int!, $perPage: Int!, $search: String) {
  Page (page: $page, perPage: $perPage) {
    pageInfo {
      currentPage
      hasNextPage
      perPage
    }
    media (id: $id, search: $search, isAdult: false) {
      id
      title {
        romaji
      }
      coverImage {
        extraLarge
      }
      siteUrl
    }
  }
}
`
- Fetch Media by ID query
    - Variables
        - `'id': Int`
    - Query
        - `query MediaByID ($id: Int) {
Media(id: $id) {
    id
    title {
        romaji
        english
        native
    }
    siteUrl
    coverImage {
        extraLarge
        color
    }
    description
    season
    seasonYear
    episodes
    genres
    averageScore
    popularity
}
}`