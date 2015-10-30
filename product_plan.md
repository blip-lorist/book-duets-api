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

## User Personas
  - Book nerds
  - Music nerds
  - Language nerds
  - Folks like [@acmei](https://github.com/acmei) who just want to see the world burn with Book Duets featuring:
    - Jane Austin + Taylor Swift
    - Margaret Brown + Rammstein
    - Sandberg + Sisqo
    - Asimov + Bowie

### Overall Goals & Guidelines
- **done** Use your product plan to lead the functionality development of their application
- **done** Create and maintain a [Trello board](https://trello.com/) to document progress on your project.
- **done** Host the application using a VPS such as Amazon EC2
- **done** Configure DNS with custom domain
- **done** Create a stylized, responsive design for all devices (phone, tablet, display)
- **done** At least 10 items of seed data for each concept/model
- Use background jobs for any long running tasks (email, image processing, 3rd party data manipulation)
- **done** Use caching for slow or bulky database interactions
- Use performance analytics to asses and optimize site performance (average server response time < 300ms)
- **done** Practice TDD to lead the development process
- **done** Integrate email (At least user signup)
- Expectations for code quality:
    - **done** 90% or greater test coverage (models and controllers)
    - Javascript tests (client and server side) w/ Mocha
    - **done** B- or greater score on Code Climate
    - No security issues (Brakeman)

### Integration Choices
  - **done** NoSql (MongoDB) **Redis for caching and query frequency tracking**
  - **done** Third-party OAuth (logging in w/ Twitter, Github, etc.)

### Advanced Feature Choices
  - **done** Service Oriented Architecture (SOA)
  - **done** Secure Public API (documented)
