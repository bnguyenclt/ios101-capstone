---
title: readme.md

---

Original App Design Project - README Template
===

# Anime Rankings+

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
* Users should be able to follow links to the anime's listing on AnimeNewsNetwork.
* Users may save specific listings in their favorites tab to find later.

**Optional Nice-to-have Stories**

* Users will be able to use certain filters when searching (studio, release date, genre, etc.).
* Users will be able to browser a list of results returned after submitting a search query.
* Users may be able to create an account with their email.
* Users may turn on push notifications to be notified of anime news.
* Users may link their AnimeNewsNetwork account to the app.

### 2. Screen Archetypes

- [ ] Search
    * Users will search for animes by names and certain filters (studio, release date, genre, etc.).
    * Users may sort anime listings by ranking (highest to lowest).
- [ ] Results Feed
    * Users will be able to browser a list of results returned after submitting a search query.
- [ ] Detail
    * Users should be able to view details of the anime when entry is expanded.
    * Users should be able to follow links to the anime's listing on AnimeNewsNetwork.
- [ ] Favorites
    * Users may save specific listings in their favorites tab to find later.
- [ ] Settings (optional features)
    * Users may be able to create an account with their email.
    * Users may turn on push notifications to be notified of anime news.
    * Users may link their AnimeNewsNetwork account to the app.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Search / Results Feed
* Favorites
* Settings

**Flow Navigation** (Screen to Screen)

- [ ]  Search / Results Feed
    * => Advanced filters
    * => Details
        * => AnimeNewsNetwork website link
- [ ] Favorites
    * => Details
        * => AnimeNewsNetwork website link
- [ ] Settings
    * => Account creation
    * => Notifications
    * => AnimeNewsNetwork account

## Wireframes

<img src="https://i.postimg.cc/SKPdWtS5/ios101-capstone-sketch-wireframe.png" width=600>

### [BONUS] Digital Wireframes & Mockups / Interactive Prototype

https://www.figma.com/design/ZGvtoio6Gxs3O4shnlMtyi/ios101-capstone-interactive-prototype?node-id=0-1&t=f65Fp8d09FpgBEV8-1

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]