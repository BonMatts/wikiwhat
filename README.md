Wikiwhat
========

A Ruby gem for extracting specific content from a [Wikipedia](http://wikipedia.com) article.


## Table of Contents

1. [Installation](#installation)
2. [Usage](#usage)
3. [Examples](#examples)
4. [Contribute](#contribute)
5. [Team](#team)
6. [License](#license)

## Installation

Add this line to your application's Gemfile:

    $ gem 'wikiwhat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wikiwhat

## Usage

This gem makes use of [Wikipedia](http://wikipedia.com), which is a Creative Commons resource. Please check out the [Wikipedia Copyright](http://en.wikipedia.org/wiki/Wikipedia:Copyrights) page for licensing information.

######To create a new Wikiwhat::Page object:

Each article to be queried should be set up as a new Wikiwhat::Page object. Queries are made via the Wikipedia API, which has limited redirect capabilities. Misspelled  or ambiguious titles may return unexpected results.

```ruby
page = Wikiwhat::Page.new("<WIKIPEDIA ARTICLE TITLE>")
```

Example:

```ruby
pigeon = Wikiwhat::Page.new("Columba livia")
albert = Wikiwhat::Page.new("Albert Einstein")
```

######Types of infomation available:

* Paragraph(s) in an article
* All paragraphs under a specific header
* A list of all image titles and corresponding URLs found in an article
* The sidebar image
* A list of all references found in an article

These methods must be done independently. We currently do not support setting multiple options at once in a single new Wikiwhat object. However, the indivudual methods can all be called on the same instance of Wikiwhat::Page.

######To get the first several paragraphs in an article:

```ruby
page = Wikiwhat::Page.new("<WIKIPEDIA ARTICLE TITLE>", :paragraphs => NUMBER)
```

You can also call .paragraphs directly on your Wikiwhat::Page object.

```ruby
page.paragraphs(2)
```

If no number is specified, `.paragraphs` defaults to `1` ie: the first paragraph on the page.

The paragraphs will be returned in an array with each paragraph as a String item in that array. The paragraphs are stored under the instance variable `@paragraphs`. Currently, the text will contain the HTML markup from the page. If more paragraphs than exist are requested, all paragraphs found on the page will be returned without errors.

Example 1:

```ruby
pigeon = Wikiwhat::Page.new("Columba livia", :paragraphs => 2)

=> ["<p>The <b>Rock Dove</b> (<i>Columba livia</i>) or <b>Rock Pigeon</b> is a member of the bird family Columbidae (doves and pigeons). In common usage, this bird is often simply referred to as the \"pigeon\".</p>",
	"\n<p>The species includes the domestic pigeon (including the fancy pigeon), and escaped domestic pigeons have given rise to feral populations around the world.</p>"]
```

Example 2:

```ruby
pigeon = Wikiwhat::Page.new("Columba livia")
pigeon.paragraphs
	
=> ["<p>The <b>Rock Dove</b> (<i>Columba livia</i>) or <b>Rock Pigeon</b> is a member of the bird family Columbidae (doves and pigeons). In common usage, this bird is often simply referred to as the \"pigeon\".</p>"]
```

######To get all the paragraphs under a specific header:

```ruby
page = Wikiwhat::Page.new("<WIKIPEDIA ARTICLE TITLE>", :header => "<Header>")
```

You can also call `.header` directly on your Wikiwhat::Page object.

```ruby
page.header("<Header>")
```

If you supply a header that is not found on the page, you will get a WikiwhatError, which is a sublcass of StandardError.

The section under the supplied Header will be returned as a String. The section is stored under the instance varaible `@header`. Currently, the text will contain HTML markup.

Example 1:

```ruby
pigeon = Wikiwhat::Page.new("Columba livia", :header => "Description")
	
=> "\n\n<p>The adult of the nominate subspecies of the Rock Dove is 29 to 37 cm (11 to 15 in) long with a 62 to 72 cm (24 to 28 in) wingspan. Weight for wild or feral Rock Doves ranges from 238–380 g (8.4–13 oz), though . . ."
```
Example 2:

```ruby
pigeon = Wikiwhat::Page.new("Columba livia")
pigeon.header("Predators")

=> 	"\n<p>With only its flying abilities protecting it from predation, rock pigeons are a favorite almost around the world for a wide range of raptorial birds. In fact, with feral pigeons existing in most every city in the world, they may form the majority of prey for several . . ."
```

######To get a list of all the images on a page, plus their URLs:

```ruby
page = Wikiwhat::Page.new("<WIKIPEDIA ARTICLE TITLE>", :img_list => true)
```

You can also call `.image_list` directly on your Wikiwhat::Page object.

```
page.image_list
```

This method will return a hash with two keys: `urls` and `titles`. Each key points to an array of strings. Currently, the Wikipedia logo image is included in the list. The hash is stored under the instance variable `@image_list`.

Example 1:

```ruby
pigeon = Wikiwhat::Page.new("Columba livia", :img_list => true)

=> {:urls=>
    ["http://upload.wikimedia.org/wikipedia/commons/4/43/Blue_Rock_Pigeon_%28Columba_livia%29_in_Kolkata_I_IMG_9762.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/e/ec/Blue_Rock_Pigeon_I4_IMG_3038.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/9/98/Columba_livia_1_day_old.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/c/ce/Columba_livia_22_days_old.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/f/ff/Columba_livia_distribution_map.png",
     "http://upload.wikimedia.org/wikipedia/commons/d/d4/Columba_livia_nest_2_eggs.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/4/4b/Doves_fighting.JPG",
     "http://upload.wikimedia.org/wikipedia/commons/1/1f/Feral_Rock_Dove_nest_with_chicks.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/d/d3/Fly_June_2008-2.jpg",
     "http://upload.wikimedia.org/wikipedia/en/4/4a/Commons-logo.svg"],
     :titles=>
    ["File:Blue Rock Pigeon (Columba livia) in Kolkata I IMG 9762.jpg",
     "File:Blue Rock Pigeon I4 IMG 3038.jpg",
     "File:Columba livia 1 day old.jpg",
     "File:Columba livia 22 days old.jpg",
     "File:Columba livia distribution map.png",
     "File:Columba livia nest 2 eggs.jpg",
     "File:Doves fighting.JPG",
     "File:Feral Rock Dove nest with chicks.jpg",
     "File:Fly June 2008-2.jpg",
     "File:Commons-logo.svg"]}
```

Example 2:

```ruby
pigeon = Wikiwhat::Page.new("Columba livia")
pigeon.find_image_list

=> {:urls=>
    ["http://upload.wikimedia.org/wikipedia/commons/4/43/Blue_Rock_Pigeon_%28Columba_livia%29_in_Kolkata_I_IMG_9762.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/e/ec/Blue_Rock_Pigeon_I4_IMG_3038.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/9/98/Columba_livia_1_day_old.jpg",
     "http://upload.wikimedia.org/wikipedia/commons/c/ce/Columba_livia_22_days_old.jpg", ...
      ]
```

######To get the sidebar image:

```ruby
page = Wikiwhat::Page.new("<WIKIPEDIA ARTICLE TITLE>", :sidebar_img => true)
```

You can also call `.sidebar_image` directly on your Wikiwhat::Page object.

```ruby
page.sidebar_image
```

This method returns the url of the sidebar image as a String. The url is stored under the instance variable `@sidebar_img`.

######To get a list of all the references on a page:

Here there be dragons. This method is a work in progress and only works on some pages.

```ruby
page = Wikiwhat::Page.new("<WIKIPEDIA ARTICLE TITLE>", :refs => true)
```

You can also call `.ref_list	` directly on your Wikiwhat::Page object.

```ruby
page.ref_list
```

This method will return an array. Each reference will be returned as a string nested inside another array. These strings will contain wiki markup. The array is stored under the instance varaible `@ref_list`.

Example 1:

```ruby
albert = Wikiwhat::Page.new("Albert Einstein", :refs => true)

=> [
    ["Zahar, Élie (2001), ''Poincaré's Philosophy. From Conventionalism to Phenomenology'', Carus Publishing Company, [http://books.google.com/?id=jJl2JAqvoSAC
   ["{{cite doi|10.1098/rsbm.1955.0005}}"],
   ["David Bodanis, ''E&nbsp;=&nbsp;mc<sup>2</sup>: A Biography of the World's Most Famous Equation'' (New York: Walker, 2000)."],
   ["{{cite web |url=http://nobelprize.org/nobel_prizes/physics/laureates/1921/ |title=The Nobel Prize in Physics 1921 |accessdate=6 March 2007 |publisher=[[N
   ["[http://wordnetweb.princeton.edu/perl/webwn?s=Einstein WordNet for Einstein]."],
   ["{{cite web|url=http://www.einstein-website.de/z_information/faq-e.html|title=Frequently asked questions|publisher=einstein-website.de|accessdate=23 July 
   ["{{cite web|url=http://www.beinglefthanded.com/Left-Handed-Einstein.html|title=Left Handed Einstein|publisher=Being Left Handed.com|accessdate=23 July 201
   ["{{Citation |first=P. A. |last=Schilpp (Ed.) |title=Albert Einstein&nbsp;– Autobiographical Notes |pages=8–9 |publisher=[[Open Court Publishing Company]] 
   ["M. Talmey, ''The Relativity Theory Simplified and the Formative Period of its Inventor''. Falcon Press, 1932, pp. 161–164."], . . . ]
```

## Contribute

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Team

[Bonnie Mattson](https://github.com/kitsunetsuki)

[Clare Glinka](https://github.com/cglinka)

## License

Gem: MIT. Fly free, little birds!

Again, all content supplied by the use of this gem is supplied by [Wikipedia](http://wikipedia.com). Please check out the [Wikipedia Copyright](http://en.wikipedia.org/wiki/Wikipedia:Copyrights) page for licensing information.
