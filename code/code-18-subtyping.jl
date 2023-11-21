# "Code example for Chapter 18 -- Subtyping"
#  C:\Users\kmpetersson\AppData\Local\Programs\Julia-1.9.3\bin\julia.exe
#  cd("E:\\aaa-Julia-course-2023\\lectures-1.9")
#---

"""
Struct definition for Card with an internal constructor.
"""

struct Card
    suit :: Int64
    rank :: Int64

    # internal constructor
    function Card(suit::Int64, rank::Int64)
        @assert(1 ≤ suit ≤ 4, "suit is not between 1 and 4")
        @assert(1 ≤ rank ≤ 13, "rank is not between 1 and 13")
        new(suit, rank)
    end
end

# call Card to create an instance with suit and rank as arguments

queen_of_diamonds = Card(2, 12)

#---

const suit_names = ["♣", "♦", "♥", "♠"]

const rank_names = ["A", "2", "3", "4", "5", "6", "7", 
    "8", "9", "10", "J", "Q", "K"]

function Base.show(io::IO, card::Card)
    print(io, rank_names[card.rank], suit_names[card.suit])
end

# rank_names[card.rank] uses the field rank from 
# the object card to index into the array rank_names

# With the methods we have so far, we can create and print cards:

Card(3, 11)

#---

import Base.<

function <(c1::Card, c2::Card)
    (c1.suit, c1.rank) < (c2.suit, c2.rank)
end

#---

abstract type CardSet end 

struct Deck <: CardSet
    cards :: Array{Card, 1}
end

function Deck()             # outer constructor
    deck = Deck(Card[])

    for suit in 1:4
        for rank in 1:13
            push!(deck.cards, Card(suit, rank))
        end
    end

    return deck
end

#---

# show method for Deck:

function Base.show(io::IO, deck::Deck)
    for card in deck.cards
        print(io, card, " ")
    end
    println()
end

Deck()

#---

function Base.pop!(deck::Deck)
    return pop!(deck.cards)
end

function Base.push!(deck::Deck, card::Card)
    push!(deck.cards, card)
    return deck
end

#---

using Random

function Random.shuffle!(deck::Deck)
    shuffle!(deck.cards)
    return deck
end

#---

# Exercise 18-2

function Base.sort!(deck::Deck)
    return sort!(deck.cards, lt=<)
end

#---

struct Hand <: CardSet
    cards :: Array{Card, 1}
    label :: String
end

function Hand(label::String="")     # outer constructor with default
    Hand(Card[], label)
end

hand = Hand("new hand")

#==
function Hand(cards::Array{Card, 1}, label::String="")     # outer constructor with default
    Hand(cards, label)
end
==#

cards = Card[]

hand = Hand(cards, "new hand")

#---

function Base.show(io::IO, cs::CardSet)
    for card in cs.cards
        print(io, card, " ")
    end
end

function Base.pop!(cs::CardSet)
    pop!(cs.cards)
end

function Base.push!(cs::CardSet, card::Card)
    push!(cs.cards, card)
    nothing
end

#---

deck = Deck()
shuffle!(deck)
card = pop!(deck)
push!(hand, card)

#---

function move!(cs1::CardSet, cs2::CardSet, n::Int)
    @assert 1 ≤ n ≤ length(cs1.cards)
    for _ in 1:n
        card = pop!(cs1)
        push!(cs2, card)
    end
    nothing
end

# Exercise 18-5

deck = Deck()
shuffle!(deck)
m, n = 2, 5

function deal!(deck::Deck, m::Int64, n::Int64)
    @assert m*n ≤ length(deck.cards)
    hands = Hand[]
    for c = 1:m
        push!(hands, Hand("Player $c"))
        move!(deck, hands[c], n)
    end
    return hands
end

ps = deal!(deck, m, n)



# Exercise 18-6


deck = Deck()
shuffle!(deck)
n = 5

function gHand(n::Int64)
    deck = shuffle!(Deck())
    @assert n ≤ length(deck.cards)
    Hand(deck.cards[1:n], "")
end

h = gHand(n)

function s_and_r(h::Hand)
    s = []
    r = []
    for c in h.cards
       push!(s, c.suit)
       push!(r, c.rank)
    end
    return s, r
end

s, r = s_and_r(h)


#==
function haspair(h::Hand)
    s, r = s_and_r(h)
    return length(collect(Set(r))) == (length(r) - 1)
end

haspair(h)
==#


function handtodict(h::Hand)
    d = Dict{Int64, Int64}()
    for c in h.cards
        d[c.rank] = get(d, c.rank, 0) + 1
     end
     return d
end

d = handtodict(h)

#---

function haspair(h::Hand)
    d = handtodict(h)
    return length(keys(d)) == (length(h.cards) - 1)
end

haspair(h)

#---

function has2pairs(h::Hand)
    d = handtodict(h)
    return (length(keys(d)) == (length(h.cards) - 2)) &&
        (2 in values(d))
end

has2pairs(h)

#---

function hastripple(h::Hand)
    d = handtodict(h)
    return (3 in values(d)) && !(2 in values(d))
end

function hasquadruple(h::Hand)
    d = handtodict(h)
    return (4 in values(d))
end

function hasstraight(h::Hand)
    d = handtodict(h)
    m, M = extrema(values(d))
    return (length(keys(d)) == length(h.cards)) &&
        (M-m + 1 == length(keys(d)))
end

function hasflush(h::Hand)
    s, r = s_and_r(h)
    return length(Set(s)) == 1
end

function hashouse(h::Hand)
    d = handtodict(h)
    return (2 in values(d)) && (3 in values(d))
end

function hasflush(h::Hand)
    s, _ = s_and_r(h)
    return (length(Set(s)) == 1)
end

function hasstraightflush(h::Hand)
    s, r = s_and_r(h)
    m, M = extrema(r)
    return (length(Set(s)) == 1) && (M-m + 1 == length(s))
end

#---

function classify(h::Hand)

    if hasstraightflush(h)
        return 9

    elseif hasquadruple(h)
        return 8

    elseif hashouse(h)
        return 7

    elseif hasflush(h)
        return 6

    elseif hasstraight(h)
        return 5

    elseif hashouse(h)
        return 4

    elseif hastripple(h)
        return 3

    elseif has2pairs(h)
        return 2

    elseif haspair(h)
        return 1

    else
        return 0
    end
end

classify(h)

#---

m = 1_000_000
results = Dict{Int64, Int64}()

for k = 1:m
    h = gHand(n)
    results[classify(h)] = get(results, classify(h), 0) + 1
end

results

hist = Dict()

for k in keys(results)
    hist[k] = results[k]/m
end

hist

s = sortperm(collect(keys(hist)))

v = collect(values(hist))[s]

#---