# Product Plan - Book Duets

- [Book Duets mockup](https://github.com/lorainekv/book-duets-api/blob/master/bookduets_mockup.pdf)
- [README](https://github.com/lorainekv/book-duets-api/blob/master/README.md)
- [Trello Board](https://trello.com/b/KVisYYDj/book-duets-capstone)

## Problem Statement
Book Duets is an API and a web app made for the amusement and curiosity of music and literature fans. Through Book Duets, you can create unique mashups of literary works and lyrics and explore trivia about author-musician pairings throughout history.

## Market Research
There doesn't seem to be anything out there that smashes book excerpts and lyrics together. Here are some related services and TwitterBots out there that use similar concepts:
-  [WriterBot](http://writerbot.com/lyrics) (Genre- and sentiment- based song mashups)
- TwitterBots that use Markov chains
  - [Erowid Recruiter](https://twitter.com/erowidrecruiter) - Erowid + Job Postings
  - [King James Programming](https://twitter.com/kjv_programming) - King James Bible + Structure and Interpretation of Computer Programs
  - [Kim Kierkegaardashian](https://twitter.com/KimKierkegaard) - Kim Kardashian + Søren Kierkegaard
  - [Kantye West](https://twitter.com/KantyeW) - Immanuel Kant + Kanye West
  - [Nihilist Arbys](https://twitter.com/nihilist_arbys) - A serving of nihilism + fast food


**How Book Duets is different:** Users can select the texts they mashup. This app also focuses specifically on author-musician connections.

The majority of these tools likely use large corpora (ie entire books), which contribute to a more natural, less repetitive Markov experience. This will be a challenge for me, since I won't necessarily have large amounts of text to work with, due to the brevity of lyrics and copyright restrictions for most commercial literary works. Since the searches need to be dynamic to accommodate an infinite number of author-musician combos, the corpora need to be temporary and lightweight.

To reduce the likelihood of boring or repetitive Book Duets, I might want to fall back on the [Brown Corpus](https://en.wikipedia.org/wiki/Brown_Corpus) as an additional text, especially if a musician has some really repetitive lyrics or a low word-count availability.  

## User Personas

  - Book nerds
  - Music nerds
  - Language nerds
  - Folks like [@acmei](https://github.com/acmei) who just want to see the world burn with Book Duets featuring:
    - Jane Austin + Taylor Swift
    - Margaret Brown + Rammstein
    - Sandberg + Sisqo
    - Asimov + Bowie

## What I've Accomplished So Far
  - Book Duets mockup
  - Markov chain practice
  - Purchased domain
  - NLP research
  - Identified necessary APIs (Musixmatch and WikiQuote)
  - Data cleaning and dictionary research
  - Chatted with two devs about data persistence, Markov chains, and performance
  - First green spec, hitting the lyrics API


## Deliverable Goals for Next Week
  - An API that returns a rough mashup of literary and lyrical content.
