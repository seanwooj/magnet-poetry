# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([
  {category: "noun"},
  {category: "verb"},
  {category: "adjective"},
  {category: "adverb"},
  {category: "preposition"},
  {category: "conjunction"},
  {category: "pronoun"},
  {category: "interjection"}
])

nouns = Word.create([
  { word: "dog", category_id: 1 },
  { word: "apple", category_id: 1 },
  { word: "car", category_id: 1 },
  { word: "blood", category_id: 1 },
  { word: "greed", category_id: 1 },
  { word: "love", category_id: 1 },
  { word: "music", category_id: 1 },
  { word: "carrot", category_id: 1 },
  { word: "circle", category_id: 1 },
  { word: "parasite", category_id: 1 },
  { word: "finger", category_id: 1 },
  { word: "rash", category_id: 1 }
])

verbs = Word.create([
  { word: "run", category_id: 2 },
  { word: "blast", category_id: 2 },
  { word: "wreck", category_id: 2 },
  { word: "cook", category_id: 2 },
  { word: "type", category_id: 2 },
  { word: "play", category_id: 2 },
  { word: "rampage", category_id: 2 },
  { word: "disappear", category_id: 2 },
  { word: "promote", category_id: 2 },
  { word: "disparge", category_id: 2 }
])

adjectives = Word.create([
  { word: "small", category_id: 3 },
  { word: "fast", category_id: 3 },
  { word: "dark", category_id: 3 },
  { word: "dank", category_id: 3 },
  { word: "irritating", category_id: 3 },
  { word: "pleasurable", category_id: 3 },
  { word: "stagnant", category_id: 3 },
  { word: "emotional", category_id: 3 },
  { word: "enthusiastic", category_id: 3 },
  { word: "piercing", category_id: 3 }
])

adverb = Word.create([
  { word: "ly", category_id: 4 },
  { word: "y", category_id: 4 }
])

prepositions = Word.create([
  { word: "on", category_id: 5 },
  { word: "beneath", category_id: 5 },
  { word: "over", category_id: 5 },
  { word: "against", category_id: 5 },
  { word: "for", category_id: 5 },
  { word: "near", category_id: 5 },
  { word: "far", category_id: 5 },
  { word: "within", category_id: 5 },
  { word: "without", category_id: 5 },
  { word: "despite", category_id: 5 }
])

conjunctions = Word.create([
  { word: "and", category_id: 6 },
  { word: "for", category_id: 6 },
  { word: "once", category_id: 6 },
  { word: "until", category_id: 6 },
  { word: "though", category_id: 6 },
  { word: "either", category_id: 6 },
  { word: "or", category_id: 6 },
  { word: "how", category_id: 6 },
  { word: "since", category_id: 6 },
  { word: "as", category_id: 6 }
])

pronouns = Word.create([
  { word: "I", category_id: 7 },
  { word: "you", category_id: 7 },
  { word: "he", category_id: 7 },
  { word: "she", category_id: 7 },
  { word: "they", category_id: 7 },
  { word: "you", category_id: 7 },
  { word: "it", category_id: 7 },
  { word: "mine", category_id: 7 },
  { word: "yours", category_id: 7 },
  { word: "theirs", category_id: 7 }
])

interjection = Word.create([
  { word: "hey", category_id: 8 },
  { word: "ouch", category_id: 8 }
])