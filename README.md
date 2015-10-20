# book-duets-api

**Currently, Book Duets is still under development as my capstone project for Ada Developers Academy. Please check back soon for active endpoint information!**

- [Book Duets Product Plan](https://github.com/lorainekv/book-duets-api/blob/master/product_plan.md)
- [Book Duets Mockup](https://github.com/lorainekv/book-duets-api/blob/master/bookduets_mockup.pdf)
- [Capstone requirements](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/master/topic_resources/capstone/capstone.md)
====================

## Table of Contents
[What Are Book Duets?](##What Are Book Duets)
[Get an API Key](##Get an API Key)
[What Are Book Duets?](##What Are Book Duets)
[What Are Book Duets?](##What Are Book Duets)
[What Are Book Duets?](##What Are Book Duets)



## What Are Book Duets?

Book Duets are computer-generated mashups of lyrics and literary excerpts. Learn more about the connections between well-known musicians and authors.

Did you know that Haruki Murakami is a fan of Radiohead? Or that Chuck Palahniuk listened to Nine Inch Nails while writing Fight Club? Learn more trivia like this by requesting a randomly-generated **Suggested Pairing** Book Duet that highlights these intriguing connections and mashes up their work.

Or try your luck at creating a **custom Book Duet** by plugging in a musician and author of your choice. You might end up with something weird, thrilling, deep, or just plain nonsensical.  

## Get an API Key

To use the Book Duets API, you'll need to register for an API key.

<pre><code> POST BASEURL + /register?email="your@email.here </code></pre>

You should receive a response that looks like this:

<pre><code> {"message":"Here is your unique API key.","api_key":"PRETEND_API_KEY"} </code></pre>

Make sure to save this unique API key, since you will need it to retrieve Book Duets.

## RESTful Endpoints

  - Base URL: Coming Soon

  - GET a suggested pairing + a book duet: <pre><code> /suggested_pairing </code></pre>

  - GET a custom book duet: <pre><code> /custom_duet?musician=MUSICIAN_NAME&author=AUTHOR_NAME </code></pre>

## Examples

Here are some amazing examples of some past computer-generated mashups:

  - /suggested_pairing

  <pre><code> {"author": "Margaret Atwood", "musician": "Feist", "news_source": "http://flavorwire.com/384073/you-favorite-authors-favorite-musicians/4, "book_duet":"Gatekeeper, Gatekeeper seasons wait for your nod I feel it all. Oooh, I'll be the case now. Instead we are opposite, we touch as though attacking, the gifts we bring even in good faith maybe warp in our hands to implements, to maneuvers in restaurants we argue over which of..."}
   </code></pre>

  - /custom_duet?musician=Hanson&author=Stephenie_Meyer

  <pre><code> {"author": "Stephenie Meyer", "musician": "Hanson", "book_duet":"I'll give you passionate, I muttered. I truly knew - knew it deep in my eyes as I thrilled to the word."} </code></pre>

## Formatting Artist Names

  The following formatting options are supported by the Book Duets endpoints
  - Spaces or Underscores (Crystal Castles, William_Gibson)
  - Special characters (Anaïs Nin, Möterhead)
  - Initials (S. E. Hinton)

  If you are having difficulty retrieving specific artists by name, check to see how they are formatted on Wikiquotes or Musixmatch. Book Duets relies on these APIs to build corpora for Markov dictionaries.

## History

## Disclaimers
