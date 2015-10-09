# Product Plan - Book Duets

Don't forget to check out the [Book Duets](https://github.com/lorainekv/book-duets-api/blob/master/bookduets_mockup.pdf) mockup and [README](https://github.com/lorainekv/book-duets-api/blob/master/README.md)

## Problem Statement
Book Duets is an API and a web app made for the amusement and curiosity of music and literature fans. Users may create custom mashups of literary works and lyrics, or they may explore suggested author-musician pairings. Through Book Duets, you can create unique mashups and explore trivia about how musicians and authors influence each other.   

## Market Research
There doesn't seem to be anything out there that smashes book excerpts and lyrics together. Here are some related services and TwitterBots out there that use similar concepts:
-  [WriterBot](http://writerbot.com/lyrics) (Genre- and sentiment- based song mashups)
- TwitterBots that use Markov chains
  - [Erowid Recruiter](https://twitter.com/erowidrecruiter)
  - [King James Programming](https://twitter.com/kjv_programming)
  - [Kim Kierkegaardashian](https://twitter.com/KimKierkegaard)
  - [Kantye West](https://twitter.com/KantyeW)
  - [Nihilist Arbys](https://twitter.com/nihilist_arbys)


**How Book Duets is different:** Users can select the texts they mashup. This app also focuses specifically on author-musician connections.

The majority of these tools likely use large corpora (ie entire books), which contribute to a more natural, less repetitive Markov experience. This will be a challenge for me, since I won't necessarily have large amounts of text to work with, due to the brevity of lyrics and copyright restrictions for most commercial literary works. Since the searches need to be dynamic to accommodate an infinite number of author-musician combos, the corpora need to be temporary and lightweight.

To reduce the likelihood of boring or repetitive Book Duets, I might want to fall back on the [Brown Corpus](https://en.wikipedia.org/wiki/Brown_Corpus) as an additional text, especially if a musician has some really repetitive lyrics or a low word-count availability.  

## User Personas

  - Book nerds
  - Music nerds
  - Language nerds
  - Folks like @acmei who just want to see the world burn with Book Duets featuring:
    - Jane Austin + Taylor Swift
    - Margaret Brown + Rammstein
    - Sandberg + Sisqo
    - Asimov + Bowie
