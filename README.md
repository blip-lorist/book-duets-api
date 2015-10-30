Feed the Book Duets API author and musician names. Receive a Markov chain mashup of their written and spoken words.

# Table of Contents
* [What Are Book Duets?](#what-are-book-duets)
* [Get an API Key](#get-api-key)
* [REST Endpoints](#rest-endpoints)
* [Examples](#examples)
* [Formatting Artist Names](#formatting-names)
* [History](#history)
* [License](#license)

# <a name="what-are-book-duets"></a> What Are Book Duets?

Book Duets are computer-generated mashups of lyrics and literary quotes. Learn more about the connections between well-known musicians and authors.

Did you know that Haruki Murakami is a fan of Radiohead? Or that Chuck Palahniuk listened to Nine Inch Nails while writing Fight Club? Learn more trivia like this by requesting a randomly-generated **Suggested Pairing** Book Duet that highlights these intriguing connections and mashes up their work.

Or try your luck at creating a **custom Book Duet** by plugging in a musician and author of your choice. You might end up with something weird, thrilling, deep, or just plain nonsensical.  

# <a name="get-api-key"></a> Get an API Key

To use the Book Duets API, you'll need to register for an API key. (If you try to get Book Duets without an API key, then you'll get a 401 Unauthorized error.)  

To register for a key:
<pre><code> POST "api.bookduets.com/register?email="your@email.here" </code></pre>

You should receive a response that looks like this:

<pre><code> {"message":"Here is your unique API key.","api_key":"YOUR_SECRET_API_KEY"} </code></pre>

Make sure to save this unique API key, since you will need it to retrieve Book Duets.

# <a name="rest-endpoints"></a> REST Endpoints

- Authentication - Once you have a unique API key, you'll need to send it in each request header for authentication, formatted as:
<pre><code> "Book-Duets-Key" => ENV['YOUR_SECRET_API_KEY'] </pre></code>

Once your API key is in the request header, then you can hit the following endpoints.    


- Base URI: <pre><code>api.bookduets.com</code></pre>

- GET a suggested pairing + a book duet: <pre><code> /suggested_pairing?filter_level=FILTER_LEVEL </code></pre>

- GET a custom book duet: <pre><code> /custom_duet?musician=MUSICIAN_NAME&author=AUTHOR_NAME&filter_level=FILTER_LEVEL </code></pre>

# <a name="parameters"></a> Parameters

- **filter_level**: This parameter is required for all lookups. Possible values include:
  - **none**: No filtering - may contain offensive or explicit language
  - **med**: Many curse words permitted, some offensive content is replaced with text bleeps (#@%!)
  - **hi**: Both offensive language and curse words replaced by text bleeps (#@%!)


- **musician**: Names (as they appear on Musixmatch)

- **author**: Names (as they appear on WikiQuotes)

# <a name="examples"></a> Examples

Here are some amazing examples of some past computer-generated mashups:

  - /suggested_pairing?filter_level=hi

  > {"author": "Margaret Atwood", "musician": "Feist", "news_source":  "http://flavorwire.com/384073/you-favorite-authors-favorite-musicians/4, "book_duet":"Gatekeeper, Gatekeeper seasons wait for your nod I feel it all. Oooh, I'll be the case now. Instead we are opposite, we touch as though attacking, the gifts we bring even in good faith maybe warp in our hands to implements, to maneuvers in restaurants we argue over which of..."}

  - /custom_duet?musician=Hanson&author=Stephenie_Meyer&filter_level=hi

  > {"author": "Stephenie Meyer", "musician": "Hanson", "book_duet":"I'll give you passionate, I muttered. I truly knew - knew it deep in my eyes as I thrilled to the word."} </code></pre>

# <a name="formatting-names"></a> Formatting Artist Names


  The following formatting options are supported by the Book Duets endpoints
  - Spaces or Underscores (Crystal Castles, William_Gibson)
  - Special characters (Anaïs Nin, Möterhead)
  - Initials (S. E. Hinton or S._E._Hinton)

  If you are having difficulty retrieving specific artists by name, check to see how they are formatted on Wikiquotes or Musixmatch. Book Duets relies on these APIs to build corpora for Markov dictionaries.

# <a name="history"></a>Project History

This was a part of my capstone project for [Ada Developers Academy](http://adadevelopersacademy.org/). As a music enthusiast and former freelance writer, I had quite a bit of fun blending my interests and putting this API together. I hope to expand on both the web app and the API in the future!

- [Book Duets Product Plan](https://github.com/lorainekv/book-duets-api/blob/master/product_plan.md)
- [Book Duets Mockup](https://github.com/lorainekv/book-duets-api/blob/master/bookduets_mockup.pdf)
- [Ada Developers Academy Capstone requirements](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/master/topic_resources/capstone/capstone.md)

Mahalo to @jnf, @kariabancroft, and my cohort[2] unigoats for your invaluable instruction and support.

# <a name="License"></a> License

MIT License
