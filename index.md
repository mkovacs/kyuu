---
layout: page
title: Kyuu
user: mkovacs
project: kyuu
tagline: Read and print repeating decimals.
---

# Introduction

Kyuu provides Haskell functions to read and print rational numbers in repeating
decimal form.

# Usage

## Include

To call the functions from a Haskell source file, import Kyuu at the
top like this:
{% highlight haskell %}
import Kyuu
{% endhighlight %}

To use the functions in [GHCi](http://www.haskell.org/haskellwiki/GHC/GHCi),
start it like this:
{% highlight bash %}
ghci kyuu.hs
{% endhighlight %}

## Notation

The general form of a rational number in repeating decimal notation consists of
three parts separated by a dot and a hash mark:
{% highlight haskell %}
[integer] . [medial] # [repetend]
{% endhighlight %}

The integer and medial parts encode the prefix, while the repetend encodes the
periodic suffix of the decimal expansion of the rational number.

All three parts are (possibly empty) sequences of decimal digits. The repetend
and the integer parts, when empty, contain an implicit 0.

In Haskell, the percent sign % is the infix operator that constructs a rational
number from its numerator and denominator.

## Examples

{% highlight haskell %}
readRD "0.#9"     =  1 % 1
readRD "33.#3"    =  100 % 3
readRD "12.3#45"  =  679 % 55

showRD (20 % 3)   =  "6.#6"
showRD (81 % 28)  =  "2.89#285714"

[1 of 1] Compiling Kyuu             ( kyuu.hs, interpreted )
Ok, modules loaded: Kyuu.
*Kyuu> readRD "0.#9"
1 % 1
*Kyuu> readRD "33.#3"
100 % 3
*Kyuu> readRD "12.3#45"
679 % 55
*Kyuu> showRD (20 % 3)
"6.#6"
*Kyuu> showRD (81 % 28)
"2.89#285714"
{% endhighlight %}
